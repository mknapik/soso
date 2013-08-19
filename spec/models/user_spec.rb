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
  end
end
