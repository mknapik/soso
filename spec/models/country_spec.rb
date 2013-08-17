# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Country do
  it 'should not save without name' do
    country = FactoryGirl.build(:country, name: nil)
    expect(country).not_to be_valid
  end

  it 'should not save with empty name' do
    country = FactoryGirl.build(:country, name: '')
    expect(country).not_to be_valid
  end
end
