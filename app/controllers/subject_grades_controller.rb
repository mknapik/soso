class SubjectGradesController < ApplicationController
  before_action :set_user, only: [:index, :sort, :create, :destroy]

  before_action :ensure_can_edit_grades

  def index
    @subject_grades = @user.subject_grades.order(:position)
    @subjects = Subject.where(committee_id: @user.committee_id).order(:name)
    @subject_grade = SubjectGrade.new
  end

  def sort
    grade_ids = params.permit(:subject_grade => [])[:subject_grade]
    raise 'Are you kidding me?' if grade_ids.blank?
    grades = SubjectGrade.find(grade_ids)
    raise 'Cannot sort subject of different users!' if grades.map { |g| g.user_id }.uniq.size > 1
    access_denied! 'cannot.edit_grades' if cannot? :edit_grades, grades.first.user

    grades = grades.index_by(&:id)
    grade_ids.each.with_index do |grade_id, index|
      grades[grade_id.to_i].update(position: index+1)
    end
    render nothing: true
  end

  def create
    sg_params = params.require(:subject_grade).permit(:user_id, :subject_id, :grade, :ects, :subject)
    subject_id = sg_params[:subject_id]
    subject_name = sg_params[:subject]

    subject = Subject.find_or_create(subject_id, subject_name, @user.committee_id)

    access_denied! 'cannot.view.subject' if cannot? :view, subject

    @subject_grade = SubjectGrade.new(user_id: @user.id, grade: sg_params[:grade], ects: sg_params[:ects], subject: subject)

    access_denied! 'cannot.create.subject_grade' if cannot? :create, @subject_grade

    if @subject_grade.save
      redirect_to profile_subject_grades_path, notice: 'Subject grade was successfully created.'
    else
      @subject_grades = @user.subject_grades.order(:position)
      @subjects = Subject.where(committee_id: @user.committee_id).order(:name)
      render 'index'
    end
  end

  def destroy
    @subject_grade = SubjectGrade.find(params[:id])
    access_denied! 'cannot.edit_grades' if cannot? :delete, @subject_grade

    subject = @subject_grade.subject
    @subject_grade.destroy
    subject.destroy if subject.subject_grades.count == 0

    redirect_to profile_subject_grades_url, notice: 'Subject grade was successfully destroyed.'
  end

  private

  def set_user
    @user = current_user
  end

  def ensure_can_edit_grades
    access_denied! 'cannot.edit_grades' if cannot? :edit_grades, @user
  end

  # Only allow a trusted parameter "white list" through.
  def subject_grade_params
    params.require(:subject_grade).permit(:subject_id, :grade, :ects)
  end
end

