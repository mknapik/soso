require 'spec_helper'

describe "language_grades/index " do
  before(:each) do
    assign(:language_grades, [
      build_stubbed(:language_grade,
        user: nil,
        language: nil,
        grade: 1.5,
        year: 1,
        paid: false
      ),
      build_stubbed(:language_grade,
        user: nil,
        language: nil,
        grade: 1.5,
        year: 1,
        paid: false
      )
    ])
  end

  it " renders a list of language_grades" do
    render

    assert_select "tr>td", text: nil.to_s, count : 2
    assert_select "tr>td", text: nil.to_s, count : 2
    assert_select "tr>td", text: 1.5.to_s, count : 2
    assert_select "tr>td", text: 1.to_s, count : 2
    assert_select "tr>td", text: false.to_s, count : 2
  end
end
