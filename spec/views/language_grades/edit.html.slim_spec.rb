require 'spec_helper'

describe "language_grades/edit " do
  before(:each) do
    @language_grade = assign(:language_grade, build_stubbed(:language_grade))
  end

  it " renders the edit language_grade form" do
    render

    assert_select "form", action: language_grades_path( @language_grade), method: "post" do
      assert_select "input#language_grade _user", name: "language_grade[user]"
      assert_select "input#language_grade _language", name: "language_grade[language]"
      assert_select "input#language_grade _grade", name: "language_grade[grade]"
      assert_select "input#language_grade _year", name: "language_grade[year]"
      assert_select "input#language_grade _paid", name: "language_grade[paid]"
    end
  end
end
