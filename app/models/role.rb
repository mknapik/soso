# == Schema Information
# Schema version: 20130331212354
#
# Table name: roles
#
# *id*::   <tt>integer, not null, primary key</tt>
# *name*:: <tt>string(255), indexed</tt>
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#--
# == Schema Information End
#++

class Role < ActiveRecord::Base
  has_many :users

  validates :name,
            presence: true,
            uniqueness: true

  def self.superadmin
    Role.where(id: 1, name: 'superadmin').first_or_create
  end

  def self.admin
    Role.where(id: 2, name: 'admin').first_or_create
  end

  def self.manager
    Role.where(id: 3, name: 'manager').first_or_create
  end

  def self.staff
    Role.where(id: 4, name: 'staff').first_or_create
  end

  def self.user
    Role.where(id: 5, name: 'user').first_or_create
  end
end
