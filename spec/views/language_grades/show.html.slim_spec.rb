require 'spec_helper'

describe "language_grades/show " do
  before(:each) do
    @language_grade = assign(:language_grade, build_stubbed(:language_grade))
  end

  it " renders attributes " do
    render

    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
