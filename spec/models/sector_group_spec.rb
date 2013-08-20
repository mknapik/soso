require 'spec_helper'

describe SectorGroup do
  it { should have_many :sectors }

  it { should validate_uniqueness_of(:name).case_insensitive }
end
