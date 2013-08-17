require 'spec_helper'

describe Role do

  it 'should not allow empty name' do
    role = build(:role_admin, name: nil)
    expect(role).not_to be_valid
  end
end
