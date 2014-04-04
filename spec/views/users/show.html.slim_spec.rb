require 'spec_helper'

describe 'profiles/show ' do
  before(:each) do
    @profile = assign(:user, build_stubbed(:user, :registered))
  end

  it ' renders attributes ' do
    render
  end
end
