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

  describe '.find_or_create' do
    context 'subject_id is present' do
      let(:subject0) { create(:subject) }

      before { expect(subject0).to be_valid }

      context 'subject exists' do
        before { subject0.save }

        it 'should find a subject' do
          found = Subject.find_or_create(subject0.id)

          expect(found).to eq(subject0)
        end

        it 'should ignore name and committee_id' do
          found1 = Subject.find_or_create(subject0.id, subject0.name)
          found2 = Subject.find_or_create(subject0.id, subject0.name, nil)
          found3 = Subject.find_or_create(subject0.id, subject0.name, subject0.committee_id)
          found4 = Subject.find_or_create(subject0.id, nil, subject0.committee_id)

          expect(found1).to eq(subject0)
          expect(found2).to eq(subject0)
          expect(found3).to eq(subject0)
          expect(found4).to eq(subject0)
        end
      end

      context 'subject does not exist' do
        it 'should raise exception' do
          expect do
            Subject.find_or_create(777, nil, nil)
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'subject_id is empty' do
      let(:subject0) { build(:subject) }

      before { expect(subject0).to be_valid }

      context 'subject_name is not present' do
        it 'should return nil' do
          committee_id = subject0.committee_id

          found = Subject.find_or_create(nil, nil, committee_id)

          expect(found).to eq(nil)
        end
      end

      context 'committee_id is not present' do
        it 'should raise exception' do
          subject_name = subject0.name

          expect do
            Subject.find_or_create(nil, subject_name, nil)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'subject exists' do
        before { subject0.save }

        it 'should find a subject for a name and committee' do
          subject_name = subject0.name
          committee_id = subject0.committee_id

          found = Subject.find_or_create(nil, subject_name, committee_id)

          expect(found).to eq(subject0)
        end
      end

      context 'subject does not exist' do
        it 'should create a subject if it does not exist' do
          subject_name = subject0.name
          committee_id = subject0.committee_id
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

end
