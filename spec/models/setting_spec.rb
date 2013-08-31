require 'spec_helper'

describe Setting do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:committee) }

  describe 'name' do

    subject { build(:setting) }

    it 'should be unique within Committee and year' do
      subject.save
      duplicate = subject.dup
      expect(duplicate).to_not accept_values(:name, subject.name.upcase)
      duplicate.name.upcase!
      expect(duplicate).to_not be_valid
    end

    it 'can be same for different Committees' do
      subject.save
      duplicate = subject.dup
      duplicate.committee = create(:committee)
      expect(duplicate).to accept_values(:name, subject.name)
      expect(duplicate).to be_valid
    end

    it 'can be same for different years' do
      subject.save
      duplicate = subject.dup
      duplicate.year += 1
      expect(duplicate).to accept_values(:name, subject.name)
      expect(duplicate).to be_valid
    end
  end
end
