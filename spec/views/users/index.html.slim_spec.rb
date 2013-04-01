require 'spec_helper'

describe 'users/index' do
  before(:each) do
    assign(:users, [
        build_stubbed(:user, name: 'Name', email: 'Email'),
        build_stubbed(:user, name: 'Name', email: 'Email')
    ])
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end


  it 'renders a list of users' do
    render
    assert_select 'tr>td', text: 'Email'.to_s, count: 2
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
  end
end
