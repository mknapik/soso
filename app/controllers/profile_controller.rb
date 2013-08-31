class ProfileController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @user = current_user
  end

  public

  def show
    access_denied! :cannot_view_profile unless can? :view_profile, @user
  end

  def edit
    access_denied! :cannot_edit_data unless can? :edit_profile, @user
  end

  def update
    access_denied! :cannot_edit_data unless can? :edit_profile, @user

    form = UserProfileForm.new(@user, params)

    if form.edit_data
      redirect_to profile_path, notice: 'User was successfully updated.'
    else
      unless @user.errors[:sector_priorities].nil?
        @user.errors[:sector_priorities].each { |error| @user.errors[:sector_ids] << error }
      end
      render action: 'edit'
    end
  end

  def get_field_of_studies
    faculty = Faculty.find(params[:faculty_id])
    access_denied! :cannot_view_profile if cannot? :view, faculty

    field_of_studies = [['', '']]
    unless params[:faculty_id] == 0
      field_of_studies += FieldOfStudy.where(faculty_id: params[:faculty_id]).map do |field_of_study|
        [field_of_study.id, field_of_study.name]
      end
    end

    respond_to do |format|
      format.json { render json: field_of_studies }
    end
  end

  def get_specializations
    field_of_study = FieldOfStudy.find(params[:field_of_study_id])
    access_denied! :cannot_view_profile if cannot? :view, field_of_study.faculty

    specializations = [['', '']]
    unless params[:field_of_study_id] == 0
      specializations += Specialization.where(field_of_study_id: params[:field_of_study_id]).map do |specialization|
        [specialization.id, specialization.name]
      end
    end

    respond_to do |format|
      format.json { render json: specializations }
    end
  end
end
