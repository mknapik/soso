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

  describe 'find_or_create' do
    describe 'subject_id is present' do
      subject { build(:subject) }

      before do
        expect(subject).to be_valid
      end

      it 'should find a subject if it exists' do
        subject.save

        found = Subject.find_or_create(subject.id)

        expect(found).to eq(subject)
      end

      it 'should ignore name and committee_id if subject_id is provided' do
        subject.save

        found1 = Subject.find_or_create(subject.id, subject.name)
        found2 = Subject.find_or_create(subject.id, subject.name, nil)
        found3 = Subject.find_or_create(subject.id, subject.name, subject.committee_id)
        found4 = Subject.find_or_create(subject.id, nil, subject.committee_id)

        expect(found1).to eq(subject)
        expect(found2).to eq(subject)
        expect(found3).to eq(subject)
        expect(found4).to eq(subject)
      end

      it 'should raise exception if subject does not exist' do
        expect {
          Subject.find_or_create(777, nil, nil)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe 'subject_id is empty' do
      subject { build(:subject) }

      before do
        expect(subject).to be_valid
      end

      it 'should find a subject for a name and committee if it exists' do
        subject.save
        subject_name = subject.name
        committee_id = subject.committee_id

        found = Subject.find_or_create(nil, subject_name, committee_id)

        expect(found).to eq(subject)
      end

      it 'should return nil if subject name is not present' do
        subject.save
        committee_id = subject.committee_id

        found = Subject.find_or_create(nil, nil, committee_id)

        expect(found.id).to eq(nil)
        expect(found).to_not be_persisted
      end

      it 'should raise exception if committee_id is not present' do
        subject.save
        subject_name = subject.name

        expect {
          Subject.find_or_create(nil, subject_name, nil)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'should create a subject if it does not exist' do
        subject_name = subject.name
        committee_id = subject.committee_id
        expect(subject).to_not be_persisted
        expect(Subject.where(name: subject_name, committee_id: committee_id).first).to be_nil

        found = Subject.find_or_create(nil, subject_name, committee_id)

        expect(found).to be_persisted
        expect(found.name).to eq(subject_name)
        expect(found.committee_id).to eq(committee_id)
      end
    end
  end

end
