# ## Schema Information
#
# Table name: users
#
# Field                       | Type               | Attributes
# --------------------------- | ------------------ | -------------------------
# **id                     ** | `integer         ` | `not null, primary key`
# **name                   ** | `string(255)     ` | `not null`
# **email                  ** | `string(255)     ` | `default(""), not null`
# **encrypted_password     ** | `string(255)     ` | `default(""), not null`
# **reset_password_token   ** | `string(255)     ` | ``
# **reset_password_sent_at ** | `datetime        ` | ``
# **remember_created_at    ** | `datetime        ` | ``
# **sign_in_count          ** | `integer         ` | `default(0)`
# **current_sign_in_at     ** | `datetime        ` | ``
# **last_sign_in_at        ** | `datetime        ` | ``
# **current_sign_in_ip     ** | `string(255)     ` | ``
# **last_sign_in_ip        ** | `string(255)     ` | ``
# **confirmation_token     ** | `string(255)     ` | ``
# **confirmed_at           ** | `datetime        ` | ``
# **confirmation_sent_at   ** | `datetime        ` | ``
# **unconfirmed_email      ** | `string(255)     ` | ``
# **failed_attempts        ** | `integer         ` | `default(0)`
# **unlock_token           ** | `string(255)     ` | ``
# **locked_at              ** | `datetime        ` | ``
# **created_at             ** | `datetime        ` | ``
# **updated_at             ** | `datetime        ` | ``
# **role_id                ** | `integer         ` | `default(3), not null`
#

require 'spec_helper'

describe User do
  describe 'validations' do

    subject { build(:user) }

    describe 'name' do
      it 'is required' do
        expect(subject).to_not accept_values(:name, nil, '')
      end

      it 'should be less than 30 characters' do
        expect(subject).to accept_values(:name, 'a' * 30)
        expect(subject).to_not accept_values(:name, 'a' * 31)
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
        subject.save
        stunt_double = subject.dup
        expect(stunt_double).to_not accept_values(:email, subject.email)
      end
    end
  end
end
