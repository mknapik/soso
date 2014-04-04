require 'spec_helper'

describe UsersController do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    attributes_for(:user, :registered)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Users Controller.Be sure to keep this updated too.
  def valid_session
    {}
  end

  before do
    # TODO Set to :user and specify authorization rules in Ability.rb.
    login_user build(:user, :registered)
  end

  describe '#show' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :show, {id: user.to_param}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

end
