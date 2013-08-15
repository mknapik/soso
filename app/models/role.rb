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
end
