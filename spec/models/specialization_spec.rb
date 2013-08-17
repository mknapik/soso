require 'spec_helper'

describe Specialization do
  it 'should not save without name' do
    specialization = FactoryGirl.build(:specialization, name: nil)
    expect(specialization).not_to be_valid
  end

  it 'should not save without field of study' do
    specialization = FactoryGirl.build(:specialization, field_of_study_id: nil)
    expect(specialization).not_to be_valid
  end

  it 'should check uniqueness of name for same field of studies' do
    FactoryGirl.create(:specialization, name: 'Specialization X')
    specialization = FactoryGirl.build(:specialization, name: 'Specialization X')
    expect(specialization).not_to be_valid
  end

  it 'should allow same name for different field of studies' do
    FactoryGirl.create(:specialization, name: 'Specialization X', field_of_study_id: 1)
    specialization = FactoryGirl.build(:specialization, name: 'Specialization X', field_of_study_id: 2)
    expect(specialization).to be_valid
  end
end
