require 'spec_helper'

describe City do
  it 'should not save without name' do
    city = FactoryGirl.build(:city, name: nil)
    expect(city).not_to be_valid
  end

  it 'should not save without country' do
    city = FactoryGirl.build(:city, country_id: nil)
    expect(city).not_to be_valid
  end

  it 'should check uniqueness of name for same countries' do
    FactoryGirl.create(:city, name: 'City')
    city = FactoryGirl.build(:city, name: 'City')
    expect(city).not_to be_valid
  end

  it 'should allow same name for different countries' do
    FactoryGirl.create(:city, name: 'City', country_id: 1)
    city = FactoryGirl.build(:city, name: 'City', country_id: 2)
    expect(city).to be_valid
  end

  it 'should check if country_id is a number' do
    city = FactoryGirl.build(:city, country_id: 'country not a number')
    expect(city).not_to be_valid
  end
end