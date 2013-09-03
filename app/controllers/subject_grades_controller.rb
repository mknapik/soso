class SubjectGradesController < ApplicationController
  # Only allow a trusted parameter "white list" through.
  def subject_grade_params
    params.require(:subject_grade).permit(:user_id, :subject_id, :grade, :ects)
  end

  def index
    @user = current_user
    access_denied! :cannot_edit_grades if cannot? :edit_grades, @user
    @subject_grades = @user.subject_grades.order(:position)
  end

  def sort
    grade_ids = params.permit(:subject_grade => [])[:subject_grade]
    raise 'Are you kidding me?' if grade_ids.blank?
    grades = SubjectGrade.find(grade_ids)
    raise 'Cannot sort subject of different users!' if grades.map { |g| g.user_id }.uniq.size > 1
    access_denied! :cannot_edit_grades if cannot? :edit_grades, grades.first.user

    grades = grades.index_by(&:id)
    grade_ids.each.with_index do |grade_id, index|
      grades[grade_id.to_i].update(position: index+1)
    end
    render nothing: true
  end

  def create
    @subject_grade = SubjectGrade.new(subject_grade_params)
    subject = Subject.find(subject_grade_params[:subject_id])
    access_denied! :change_me if cannot? :view, subject

    if @subject_grade.save
      redirect_to @subject_grade, notice: 'Subject grade was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @subject_grade.update(subject_grade_params)
      redirect_to @subject_grade, notice: 'Subject grade was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @subject_grade.destroy
    redirect_to subject_grades_url, notice: 'Subject grade was successfully destroyed.'
  end
end
