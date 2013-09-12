class LanguageGradesController < ApplicationController
  #before_action :set_language_grade, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @language_grades = @user.language_grades
    @languages = @user.try(:committee).try(:languages)

    #@language_grade = SubjectGrade.new
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

    old_language_grades = @user.language_grades.where(language_id: language_ids).to_a
    language_grade_ids = old_language_grades.map { |lg| lg.language_id }
    new_language_grades = languages.reject { |lang| language_grade_ids.include? lang.id }.map do |lang|
      LanguageGrade.new(language: lang, user: @user, year: Setting.year(@user.committee_id))
    end

    sleep(1)
    @user.language_grades.where('language_id NOT IN (?)', language_grade_ids)
    @user.language_grades = old_language_grades + new_language_grades
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  #def set_language_grade
  #  @language_grade = LanguageGrade.find(params[:id])
  #end

  def user_language_grades_params
    params.require(:user).permit(:id, :language_ids => [])
  end
end
