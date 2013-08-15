require 'spec_helper'

describe User do
  describe 'validations' do

    subject { build(:user) }

    describe 'name and surname' do
      it 'is required' do
        expect(subject).to_not accept_values(:name, nil, '')
        expect(subject).to_not accept_values(:surname, nil, '')
      end

      it 'should be less than 50 characters' do
        expect(subject).to accept_values(:name, 'a' * 50)
        expect(subject).to_not accept_values(:name, 'a' * 51)
        expect(subject).to accept_values(:surname, 'a' * 50)
        expect(subject).to_not accept_values(:surname, 'a' * 51)
      end
    end

    describe 'email' do
      it 'is required' do
        expect(subject).to_not accept_values(:email, nil, '', ' ')
      end

      it 'must be properly formatted' do
        expect(subject).to accept_values(:email, 'a@b.com', 'a@b.c.com')
        expect(subject).to_not accept_values(:email, 'a@b', 'a.b.com')
      end

      it 'must be unique' do
        puts subject.inspect
        subject.save
        stunt_double = subject.dup
        puts stunt_double.inspect
        expect(stunt_double).to_not accept_values(:email, subject.email)
      end
    end
  end
end
