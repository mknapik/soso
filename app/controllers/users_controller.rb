class UsersController < ApplicationController
  before_action :set_profile

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @user = User.find(params[:user_id] || params[:id])

    access_denied! 'cannot.view.user' unless can? :view, @user
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
      redirect_to user_path(@user), notice: 'User was successfully updated.'
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
      redirect_to user_path(@user), notice: 'Profile was successfully locked.'
    else
      redirect_to user_path(@user), flash: {error: 'Profile cannot be locked.'}
    end
  end

  def unlock
    access_denied! 'cannot.unlock_profile' if cannot? :unlock_profile, @user

    if @user.unlock_profile
      redirect_to user_path(@user), notice: 'Profile was unlocked.'
    else
      redirect_to user_path(@user), flash: {error: 'Profile cannot be unlocked.'}
    end
  end

  # staff
  def confirm_grades
    access_denied! 'cannot.confirm_grades' if cannot? :confirm_grades, @user

    @user.confirm_grades

    redirect_to user_path(@user), notice: 'Grades confirmed!'
  end
  def disapprove_grades
    access_denied! 'cannot.disapprove_grades' if cannot? :disapprove_grades, @user

    @user.disapprove_grades

    redirect_to user_path(@user), notice: 'Grades disapproved!'
  end
end
