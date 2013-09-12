class LanguageGradesController < ApplicationController
  before_action :set_language_grade, only: [:show, :edit, :update, :destroy]
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

  def create
    @language_grade = LanguageGrade.new(language_grade_params)

    if @language_grade.save
      redirect_to @language_grade, notice: 'Language grade was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @language_grade.update(language_grade_params)
      redirect_to @language_grade, notice: 'Language grade was successfully updated.'
    else
      render action: 'edit'
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

  def set_language_grade
    @language_grade = LanguageGrade.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def language_grade_params
    params.require(:language_grade).permit(:user_id, :language_id, :grade, :year, :paid)
  end
end
