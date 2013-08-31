require 'spec_helper'

describe Subject do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:committee) }
  it { should validate_uniqueness_of(:name).scoped_to(:committee_id).case_insensitive }

  describe 'name' do

    subject { build(:subject) }

    it 'should be unique within Committee' do
      subject.save
      duplicate = subject.dup
      duplicate.name.upcase!
      expect(duplicate).to_not accept_values(:name, subject.name)
      expect(duplicate).to_not be_valid
    end

    it 'can be same for different Committees' do
      subject.save
      duplicate = subject.dup
      duplicate.committee = create(:committee)
      expect(duplicate).to accept_values(:name, subject.name)
      expect(duplicate).to be_valid
    end
  end

end
