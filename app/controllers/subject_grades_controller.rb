class SubjectGradesController < ApplicationController
  # Only allow a trusted parameter "white list" through.
  def subject_grade_params
    params.require(:subject_grade).permit(:user_id, :subject_id, :grade, :ects)
  end

  def index
    @user = current_user
    access_denied! :cannot_edit_grades if cannot? :edit_grades, @user

    @subject_grades = @user.subject_grades.order(:position)
    @subject_grade = SubjectGrade.new
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
    @user = current_user
    access_denied! :cannot_edit_grades if cannot? :edit_grades, @user

    sg_params = params.require(:subject_grade).permit(:user_id, :subject_id, :grade, :ects, :subject)
    subject_id = sg_params[:subject_id]
    subject_name = sg_params[:subject]

    subject = if subject_id.blank?
                # TODO: refactor
                if subject_name.blank?
                  Subject.new(committee_id: current_user.committee_id)
                else
                  subject = Subject.where('UPPER(name) = UPPER(?) AND committee_id = ?',
                                          subject_name, @user.committee_id).first
                  if subject.nil?
                    Subject.create(name: subject_name, committee_id: current_user.committee_id)
                  else
                    subject
                  end
                end
              else
                Subject.find(subject_id)
              end

    access_denied! :cannot_view_subject if cannot? :view, subject

    @subject_grade = SubjectGrade.new
    @subject_grade.user_id = current_user.id
    @subject_grade.grade = sg_params[:grade]
    @subject_grade.ects = sg_params[:ects]
    @subject_grade.subject_id = subject.id

    if @subject_grade.save
      redirect_to profile_subject_grades_path,
                  notice: 'Subject grade was successfully created.'
    else
      @subject_grades = @user.subject_grades.order(:position)
      render 'index'
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
    @user = current_user
    @subject_grade = SubjectGrade.find(params[:id])
    access_denied! :cannot_edit_grades if cannot? :edit_grades, @user

    @subject_grade.destroy
    redirect_to profile_subject_grades_url, notice: 'Subject grade was successfully destroyed.'
  end
end

