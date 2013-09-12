require 'spec_helper'

describe "language_grades/new " do
  before(:each) do
    assign(:language_grade, build_stubbed(:language_grade))
  end

  it " renders new language_grade form" do
    render

    assert_select "form", action: language_grades_path, method : "post" do
      assert_select "input #language_grade_user", name: "language_grade[user]"
           assert_select "input #language_grade_language", name: "language_grade[language]"
           assert_select "input #language_grade_grade", name: "language_grade[grade]"
           assert_select "input #language_grade_year", name: "language_grade[year]"
           assert_select "input #language_grade_paid", name: "language_grade[paid]"
         end
  end
end

