class ExamsController < ApplicationController
  before_action :set_user

  before_action :set_exam, only: [:show, :edit, :update, :destroy]

  def index
    exams = Exam.available(@user.id, @user.committee_id)
    @language_exams = exams.group_by {|e| e.language}
  end

  def show
  end

  def new
    @exam = Exam.new
  end

  def edit
  end

  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      redirect_to @exam, notice: 'Exam was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @exam.update(exam_params)
      redirect_to @exam, notice: 'Exam was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @exam.destroy
    redirect_to exams_url, notice: 'Exam was successfully destroyed.'
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
