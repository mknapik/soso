class LanguageGradesController < ApplicationController
  #before_action :set_language_grade, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @language_grades = @user.language_grades.where('grade IS NOT NULL')
    language_grades = @user.language_grades.where('grade IS NULL')
    @languages = @user.committee.languages.map do |language|
      lgs = language_grades.select { |lg| lg.language_id == language.id }
      {
          language: language,
          checked: !lgs.empty?,
          paid: lgs.detect { |lg| lg.paid }
      }
    end
  end

  def show
  end

  def new
    @language_grade = LanguageGrade.new
  end

  def edit
  end

  def update
    language_ids = user_language_grades_params[:language_ids]
    language_ids = [] if language_ids.nil?

    access_denied! 'cannot.choose_language' if cannot? :choose_language, @user

    languages = Language.find(language_ids)
    access_denied! 'cannot.choose_language' if languages.detect { |lang| cannot? :choose, lang }

    @user.language_choices(languages)

    respond_to do |format|
      if @user.save
        format.json { render :json => {success: true} }
      else
        format.json { render :json => {success: false, errors: @user.errors} }
      end
    end
  end

  def destroy
    @language_grade.destroy
    redirect_to language_grades_url, notice: 'Language grade was successfully destroyed.'
  end

  def lock
    access_denied! 'cannot.lock_language' if cannot? :lock_language, @user

    @user.lock_language

    redirect_to page_path('payment'), notice: 'Your language choice was permanently saved.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])

    access_denied! 'cannot.view.users' unless can? :view, @user
  end
  #def set_language_grade
  #  @language_grade = LanguageGrade.find(params[:id])
  #end

  def user_language_grades_params
    params.require(:user).permit(:id, :language_ids => [])
  end
end
