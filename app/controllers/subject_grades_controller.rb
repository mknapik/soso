class SubjectGradesController < ApplicationController
  before_action :set_user

  before_action :ensure_can_edit_grades, except: [:index]

  def index
    access_denied! 'cannot.view_grades' if cannot? :view_grades, @user

    @subject_grades = @user.subject_grades.order(:position)
    @subjects = Subject.where(committee_id: @user.committee_id).order(:name)
    @subject_grade = SubjectGrade.new
  end

  def edit
    @subject_grades = @user.subject_grades.order(:position)
    @subjects = Subject.where(committee_id: @user.committee_id).order(:name)
    @subject_grade = SubjectGrade.new
  end

  def sort
    grade_ids = params.permit(subject_grade: [])[:subject_grade]
    raise 'Are you kidding me?' if grade_ids.blank?
    grades = SubjectGrade.find(grade_ids)
    raise 'Cannot sort subject of different users!' if grades.map { |g| g.user_id }.uniq.size > 1
    access_denied! 'cannot.edit_grades' if cannot? :edit_grades, grades.first.user

    grades = grades.index_by(&:id)
    grade_ids.each.with_index do |grade_id, index|
      grades[grade_id.to_i].update(position: index + 1)
    end
    render nothing: true
  end

  def create
    sg_params = subject_grade_params(:subject)

    subject = Subject.find_or_create(sg_params[:subject_id], sg_params[:subject], @user.committee_id)

    unless subject.nil?
      access_denied! 'cannot.view.subject' if cannot? :read, subject
    end

    @subject_grade = SubjectGrade.new(user_id: @user.id, grade: sg_params[:grade], ects: sg_params[:ects], subject: subject)

    access_denied! 'cannot.create.subject_grade' if cannot? :create, @subject_grade

    if @subject_grade.save
      redirect_to edit_user_subject_grades_path(@user), notice: 'Subject grade was successfully created.'
    else
      @subject_grades = @user.subject_grades.order(:position)
      @subjects = Subject.where(committee_id: @user.committee_id).order(:name)
      render 'edit'
    end
  end

  def destroy
    @subject_grade = SubjectGrade.find(params[:id])
    access_denied! 'cannot.edit_grades' if cannot? :destroy, @subject_grade

    @subject_grade.destroy

    redirect_to edit_user_subject_grades_path(@user), notice: 'Subject grade was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])

    access_denied! 'cannot.view.user' unless can? :read, @user
  end

  def ensure_can_edit_grades
    access_denied! 'cannot.edit_grades' if cannot? :edit_grades, @user
  end

  # Only allow a trusted parameter "white list" through.
  def subject_grade_params(*extra_params)
    permitted = [:subject_id, :grade, :ects]
    extra_params.each { |param| permitted << param }
    params.require(:subject_grade).permit(permitted)
  end
end

