require 'spec_helper'

describe SectorPriority do
  it { should belong_to :sector }
  it { should belong_to :user }

  it { should validate_presence_of :sector_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :priority }

  it { should validate_uniqueness_of(:priority).scoped_to(:user_id) }
  it { should validate_uniqueness_of(:sector_id).scoped_to(:user_id) }
end
