require 'spec_helper'

describe Sector do
  it { should belong_to :sector_group }
  it { should have_many :sector_priorities }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:sector_group_id).case_insensitive }
end
