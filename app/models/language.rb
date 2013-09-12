# == Schema Information
# Schema version: 20130911142514
#
# Table name: languages
#
# *id*::       <tt>integer, not null, primary key</tt>
# *name*::     <tt>string(255), not null, indexed</tt>
# *iso_code*:: <tt>string(3), not null, indexed</tt>
#
# Indexes
#
#  index_languages_on_iso_code  (iso_code) UNIQUE
#  index_languages_on_name      (name) UNIQUE
#--
# == Schema Information End
#++

class Language < ActiveRecord::Base
  has_many :countries

  has_many :language_grades
  #has_many :users, :through => :language_grades
  has_and_belongs_to_many :committees

  validates :iso_code,
            presence: true,
            uniqueness: true,
            length: {is: 3}
  validates :name,
            presence: true,
            uniqueness: true
end
