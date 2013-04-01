# == Schema Information
# Schema version: 20130331212354
#
# Table name: users
#
# *id*::                     <tt>integer, not null, primary key</tt>
# *name*::                   <tt>string(255), not null</tt>
# *email*::                  <tt>string(255), default(""), not null, indexed</tt>
# *encrypted_password*::     <tt>string(255), default(""), not null</tt>
# *reset_password_token*::   <tt>string(255), indexed</tt>
# *reset_password_sent_at*:: <tt>datetime</tt>
# *remember_created_at*::    <tt>datetime</tt>
# *sign_in_count*::          <tt>integer, default(0)</tt>
# *current_sign_in_at*::     <tt>datetime</tt>
# *last_sign_in_at*::        <tt>datetime</tt>
# *current_sign_in_ip*::     <tt>string(255)</tt>
# *last_sign_in_ip*::        <tt>string(255)</tt>
# *confirmation_token*::     <tt>string(255), indexed</tt>
# *confirmed_at*::           <tt>datetime</tt>
# *confirmation_sent_at*::   <tt>datetime</tt>
# *unconfirmed_email*::      <tt>string(255)</tt>
# *failed_attempts*::        <tt>integer, default(0)</tt>
# *unlock_token*::           <tt>string(255), indexed</tt>
# *locked_at*::              <tt>datetime</tt>
# *created_at*::             <tt>datetime</tt>
# *updated_at*::             <tt>datetime</tt>
# *role_id*::                <tt>integer, default(3), not null</tt>
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#--
# == Schema Information End
#++

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role_id

  validates :name,
            presence: true,
            length: {maximum: 30}

  validates :email,
            presence: true,
            email: true,
            uniqueness: true

  validates :password,
            presence: true,
            length: {minimum: 6},
            if: :password
end
