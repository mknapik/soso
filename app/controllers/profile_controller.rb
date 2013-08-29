class ProfileController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]

  def show
  end

  def edit
    access_denied! :cannot_edit_data unless can? :edit_data, @user
  end

  def update
    form = UserProfileForm.new(params)
    p = form.params
    sector_ids = p.delete(:sector_ids)

    @user.assign_attributes(form.params)
    @user.sector_ids = sector_ids

    access_denied! :cannot_edit_data unless can? :edit_data, @user

    if @user.edit_data
      redirect_to profile_path, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def get_field_of_studies
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @user = current_user
  end
end
