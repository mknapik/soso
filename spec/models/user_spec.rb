require 'spec_helper'

describe User do

  it { should belong_to :role }
  it { should belong_to :committee }
  it { should belong_to :faculty }
  it { should belong_to :field_of_study }
  it { should belong_to :specialization }

  describe 'validations' do

    subject { build(:user, :registered) }

    it 'should be able to register' do
      expect(subject).to be_valid
    end

    describe 'all required personal data: name, surname, student_no, committee, email' do
      it 'is required' do
        expect(subject).to_not accept_values(:email, nil, '', ' ')
        expect(subject).to_not accept_values(:name, nil, '', ' ')
        expect(subject).to_not accept_values(:surname, nil, '', ' ')
        expect(subject).to_not accept_values(:student_no, nil, '', ' ')
        expect(subject).to_not accept_values(:committee_id, nil, '', ' ')
      end
    end

    describe 'name and surname' do
      it 'should be less than 50 characters' do
        expect(subject).to accept_values(:name, 'a' * 50)
        expect(subject).to_not accept_values(:name, 'a' * 51)
        expect(subject).to accept_values(:surname, 'a' * 50)
        expect(subject).to_not accept_values(:surname, 'a' * 51)
      end
    end

    describe 'password' do
      it 'should have required length' do
        expect(subject).to_not accept_values(:password, nil, '', '12345')
      end
    end

    describe 'student_no' do
      it 'must be unique for same committee' do
        subject.student_no = 'a12'
        subject.save
        stunt_double = subject.dup
        stunt_double.student_no.upcase!
        expect(stunt_double).to_not accept_values(:student_no, subject.student_no)
      end

      it 'can be the same for different committees' do
        subject.save
        stunt_double = subject.dup
        stunt_double.committee_id = 1
        expect(stunt_double).to accept_values(:student_no, subject.student_no)
      end
    end

    describe 'email' do
      it 'must be properly formatted' do
        expect(subject).to accept_values(:email, 'a@b.com', 'a@b.c.com')
        expect(subject).to_not accept_values(:email, 'a@b', 'a.b.com')
      end

      it 'must be unique' do
        subject.save
        stunt_double = subject.dup
        stunt_double.email.upcase!
        expect(stunt_double).to_not accept_values(:email, subject.email)
        should validate_uniqueness_of :email
      end
    end

    describe 'sectors' do
      subject { create(:user, :registered, :confirmed) }

      before do
        @sp_count = SectorPriority.count
      end

      it 'should allow to add up to 3 sectors' do
        sectors = [create(:sector)]
        subject.save

        priorities = sectors.map.with_index do |sector, index|
          subject.sector_priorities.build(sector: sector, priority: index+1)
        end

        expect(subject).to accept_values(:sector_priorities, priorities)
        expect(subject.save).to be_true
        expect(SectorPriority.count).to eq(@sp_count + sectors.size)
      end
      it 'should not allow to add more than 3 sectors' do
        sectors = 4.times.map { create(:sector) }
        expect(subject).to be_valid
        subject.state = 'profile_filled'

        priorities = sectors.map.with_index do |sector, index|
          subject.sector_priorities.build(sector: sector, priority: index+1)
        end

        expect(subject).to_not accept_values(:sector_priorities, priorities)
        expect(subject.errors_on(:sector_priorities)).to include('number of elements is not between 1 and 3')
        expect(subject.save).to be_false
        expect(SectorPriority.count).to eq(@sp_count)
      end
      it 'sector_ids should be unique' do
        sector = create(:sector)
        sectors = 2.times.map { sector }
        expect(subject).to be_valid
        subject.state = 'profile_filled'

        priorities = sectors.map.with_index do |sector, index|
          subject.sector_priorities.build(sector: sector, priority: index+1)
        end

        expect(subject).to_not accept_values(:sector_priorities, priorities)
        expect(subject.errors_on(:sector_priorities)).to include('sector_id are not unique')
        expect(subject.save).to be_false
        expect(SectorPriority.count).to eq(@sp_count)
      end
      it 'priorities should be unique' do
        sectors = 2.times.map { create(:sector) }
        expect(subject).to be_valid
        subject.state = 'profile_filled'

        priorities = sectors.map do |sector|
          subject.sector_priorities.build(sector: sector, priority: 1)
        end

        expect(subject).to_not accept_values(:sector_priorities, priorities)
        expect(subject.errors_on(:sector_priorities)).to include('priority are not unique')
        expect(subject.save).to be_false
        expect(SectorPriority.count).to eq(@sp_count)
      end

      describe 'sector orphans' do
        before do
          sectors = 2.times.map { create(:sector) }
          expect(subject).to be_valid
          subject.state = 'profile_filled'
          @priorities = sectors.map.with_index do |sector, index|
            subject.sector_priorities.build(sector: sector, priority: index+1)
          end
          expect(subject).to be_valid
          subject.save
          expect(SectorPriority.count).to eq(@sp_count + @priorities.size)
        end

        it 'sectors should not be changed if profile is invalid' do
          size = @priorities.size
          priorities = @priorities
          priorities << subject.sector_priorities.build(sector: create(:sector), priority: 3)
          priorities << subject.sector_priorities.build(sector: create(:sector), priority: 4)
          expect(subject).to_not accept_values(:sector_priorities, @priorities)
          expect(subject).to_not be_valid
          expect(subject.save).to be_false
          expect(SectorPriority.count).to eq(@sp_count + size)
        end
        it 'old sectors should be deleted if new ones are valid' do
          priorities = []
          priorities << subject.sector_priorities.build(sector: create(:sector), priority: 3)
          priorities << subject.sector_priorities.build(sector: create(:sector), priority: 4)
          subject.set_priorities(priorities)
          expect(subject).to be_valid
          expect(subject.save).to be_true
          expect(SectorPriority.count).to eq(priorities.size)
        end
      end
    end
  end
end
