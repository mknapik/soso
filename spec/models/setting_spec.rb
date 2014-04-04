require 'spec_helper'

describe Setting do
  let(:committee) { build(:committee) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:committee) }

  describe '#name' do

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

  describe '.year' do
    subject { Setting.year(committee) }

    context 'committee does not exist' do
      it 'should throw exception' do
        expect do
          subject
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'committee exists' do
      before { committee.save }

      context 'setting year is not set' do
        it 'should throw exception' do
          expect do
            subject
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'setting year is set' do
        let!(:year) { Time.now.year }
        let!(:setting) { create(:setting, :year, committee: committee) }

        it 'should return current_year' do
          expect(subject).to eq(setting.value)
          expect(subject).to eq(year)
        end
      end
    end
  end

  describe '.year=' do
    subject { Setting.year = [committee, year] }

    let(:year) { 2013 }

    before { committee.save }

    it 'should set year' do
      subject

      expect(Setting.find_by!(committee: committee, name: :year, year: 0).value.to_i).to eq(year)
    end
  end

  describe '.stage' do
    subject { Setting.stage(committee) }

    let!(:stage) { create(:stage, committee: committee) }

    context 'setting year is set' do
      let!(:year) { Time.now.year }
      let!(:setting) { create(:setting, :year, committee: committee) }

      before { create(:setting, name: :stage, value: stage, committee: committee, year: year) }

      it 'should return current stage' do
        expect(subject).to eq(stage)
      end
    end
  end

  describe '.stage=' do
    subject { Setting.stage = [committee, stage] }

    let(:year) { 2013 }
    let!(:stage) { create(:stage, committee: committee) }

    before { committee.save }

    context 'setting year is set' do
      let!(:year) { Time.now.year }
      let!(:setting) { create(:setting, :year, committee: committee) }

      it 'should set stage' do
        subject

        expect(Setting.find_by!(committee: committee, name: :stage, year: year).value.to_i).to eq(stage.id)
      end
    end
  end
end
