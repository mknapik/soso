class UsersController < ProfileController
  before_action :set_profile

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @user = User.find(params[:id] || params[:user_id])
  end

  public
end
