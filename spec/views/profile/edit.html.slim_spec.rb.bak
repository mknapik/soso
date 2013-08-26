require 'spec_helper'

describe "profile/edit " do
  before(:each) do
    @profile = assign(:profile, build_stubbed(:profile))
  end

  it " renders the edit profile form" do
    render

    assert_select "form", action: profiles_path( @profile), method: "post" do
    end
  end
end
