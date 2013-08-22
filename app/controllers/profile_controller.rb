class ProfileController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]

  def show
  end

  def edit

  end

  def update
    form = UserProfileForm.new(params)
    if @user.update(form.params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @user = current_user
  end
end
