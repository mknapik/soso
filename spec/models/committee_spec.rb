# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Committee do
  it 'should not save without name' do
    committee = FactoryGirl.build(:committee, name: nil)
    expect(committee).not_to be_valid
  end

  it 'should not save without city' do
    committee = FactoryGirl.build(:committee, city_id: nil)
    expect(committee).not_to be_valid
  end

  it 'should check uniqueness of name for same cities' do
    FactoryGirl.create(:committee, name: 'Committee')
    committee = FactoryGirl.build(:committee, name: 'Committee')
    expect(committee).not_to be_valid
  end

  it 'should allow same name for different cities' do
    FactoryGirl.create(:committee, name: 'Committee', city_id: 1)
    committee = FactoryGirl.build(:committee, name: 'Committee', city_id: 2)
    expect(committee).to be_valid
  end

  it 'should check if city_id is a number' do
    committee = FactoryGirl.build(:committee, city_id: 'not a number')
    expect(committee).not_to be_valid
  end
end
