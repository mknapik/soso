class LanguageGradesController < ApplicationController
  #before_action :set_language_grade, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    access_denied! 'cannot.choose_language' if cannot? :choose_language, @user

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

  # staff

  def payment
    access_denied! 'cannot.pay_exam_fee' if cannot? :pay_exam_fee, @user

    @language_grades = @user.language_enrolled_exams
    redirect_to user_path(@user), flash: {error: 'User has not signed up for any exam!'} if @language_grades.empty?
  end

  def skip
    access_denied! 'cannot.skip_exam' if cannot? :skip_exam, @user
  end

  def pay
    language_grade_ids = params.require(:user).permit(:id, :language_grade_ids => [])[:language_grade_ids]
    language_grade_ids = [] if language_grade_ids.nil?
    language_grade_ids.map!(&:to_i)

    access_denied! 'cannot.pay_exam_fee' if cannot? :pay_exam_fee, @user

    @language_grades = @user.language_enrolled_exams
    if @language_grades.blank?
      redirect_to user_path(@user), flash: {error: 'User has not signed up for any exam!'}
    else
      @user.language_grades.map! do |language_grade|
        if language_grade.id.in? @language_grades.map(&:id)
          access_denied! 'cannot.view.language_grade' if cannot? :edit, language_grade
          language_grade.paid = language_grade.id.in? language_grade_ids
          language_grade.save
        end
        language_grade
      end

      if @user.pay_exam_fee
        redirect_to user_path(@user), notice: 'Language exam fees have been paid!'
      else
        puts @user.inspect
        puts @user.errors.inspect
        render action: :payment
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])

    access_denied! 'cannot.view.users' unless can? :view, @user
  end

  def user_language_grades_params
    params.require(:user).permit(:id, :language_ids => [])
  end
end
