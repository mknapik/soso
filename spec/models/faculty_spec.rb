require 'spec_helper'

describe Faculty do
  it 'should not save without name' do
    faculty = FactoryGirl.build(:faculty, name: nil)
    expect(faculty).not_to be_valid
  end

  it 'should not save without committee' do
    faculty = FactoryGirl.build(:faculty, committee_id: nil)
    expect(faculty).not_to be_valid
  end

  it 'should check uniqueness of name for same committees' do
    FactoryGirl.create(:faculty, name: 'Faculty X')
    faculty = FactoryGirl.build(:faculty, name: 'Faculty X')
    expect(faculty).not_to be_valid
  end

  it 'should allow same name for different committees' do
    FactoryGirl.create(:faculty, name: 'Faculty X', committee_id: 1)
    faculty = FactoryGirl.build(:faculty, name: 'Faculty X', committee_id: 2)
    expect(faculty).to be_valid
  end
end
