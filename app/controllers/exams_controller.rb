class ExamsController < ApplicationController
  before_action :set_user

  before_action :set_exam, only: [:sign_up, :release]

  def index
    access_denied! 'cannot.choose_exam' if cannot? :choose_exam, @user

    exams = Exam.available(@user)
    @language_exams = exams.group_by {|e| e.language}

    @signed_up_exams = @user.language_signed_up_exams
  end

  def sign_up
    access_denied! 'cannot.choose_exam', user_exams_path(@user) if cannot? :choose_exam, @user

    if @user.exam_sign_up(@exam)
      redirect_to user_exams_path(@user), notice: "You've been signed up for #{@exam.name}."
    else
      redirect_to user_exams_path(@user), flash: {error: "You cannot sign up for #{@exam.name}"}
    end
  end

  def release
    access_denied! 'cannot.choose_exam', user_exams_path(@user) if cannot? :choose_exam, @user

    if @user.exam_release(@exam)
      redirect_to user_exams_path(@user), notice: "You've released the #{@exam.name}."
    else
      redirect_to user_exams_path(@user), flash: {error: "You cannot released the #{@exam.name}"}
    end
  end

  def lock
    access_denied! 'cannot.lock_exam', user_exams_path(@user) if cannot? :lock_exam, @user

    if @user.lock_exam
      redirect_to page_path('exams'), notice: 'You have confirmed exam choices!'
    else
      redirect_to user_path(@user), flash: {error: 'You cannot confirm exams!'}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])

    access_denied! 'cannot.view.user' unless can? :view, @user
  end

  def set_exam
    @exam = Exam.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def exam_params
    params.require(:exam).permit(:language_id, :datetime, :min, :max, :state)
  end
end
