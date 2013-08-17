require 'spec_helper'

describe FieldOfStudy do
  it 'should not save without name' do
    field_of_study = FactoryGirl.build(:field_of_study, name: nil)
    expect(field_of_study).not_to be_valid
  end

  it 'should not save without faculty' do
    field_of_study = FactoryGirl.build(:field_of_study, faculty_id: nil)
    expect(field_of_study).not_to be_valid
  end

  it 'should check uniqueness of name for same faculties' do
    FactoryGirl.create(:field_of_study, name: 'Field of Study X')
    field_of_study = FactoryGirl.build(:field_of_study, name: 'Field of Study X')
    expect(field_of_study).not_to be_valid
  end

  it 'should allow same name for different faculties' do
    FactoryGirl.create(:field_of_study, name: 'Field of Study X', faculty_id: 1)
    field_of_study = FactoryGirl.build(:field_of_study, name: 'Field of Study X', faculty_id: 2)
    expect(field_of_study).to be_valid
  end
end
