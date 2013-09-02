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

    if form.edit_profile
      redirect_to profile_path, notice: 'User was successfully updated.'
    else
      unless @user.errors[:sector_priorities].nil?
        @user.errors[:sector_priorities].each { |error| @user.errors[:sector_ids] << error }
      end
      render action: 'edit'
    end
  end
end
