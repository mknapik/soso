class ProfileController < ApplicationController
  before_action :set_profile

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @user = current_user
  end

  public

  def show
    access_denied! 'cannot.view_profile' unless can? :view_profile, @user
  end

  def edit
    access_denied! 'cannot.edit_profile' unless can? :edit_profile, @user
  end

  def update
    access_denied! 'cannot.edit_profile' unless can? :edit_profile, @user

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

  def lock
    access_denied! 'cannot.lock_profile' if cannot? :lock_profile, @user

    if @user.lock_profile
      redirect_to profile_path, notice: 'Profile was successfully locked.'
    else
      redirect_to profile_path, flash: {error: 'Profile cannot be locked.'}
    end
  end

  def unlock
    access_denied! 'cannot.unlock_profile' if cannot? :unlock_profile, @user

    if @user.unlock_profile
      redirect_to profile_path, notice: 'Profile was unlocked.'
    else
      redirect_to profile_path, flash: {error: 'Profile cannot be unlocked.'}
    end
  end

  def skip_exam
    access_denied! 'cannot.skip_exam' if cannot? :skip_exam, @user
  end
end
