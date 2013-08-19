# == Schema Information
# Schema version: 20130819143045
#
# Table name: countries
#
# *id*::          <tt>integer, not null, primary key</tt>
# *name*::        <tt>string(255), not null, indexed</tt>
# *code*::        <tt>string(255), not null, indexed</tt>
# *language_id*:: <tt>integer, indexed</tt>
#
# Indexes
#
#  index_countries_on_code         (code) UNIQUE
#  index_countries_on_language_id  (language_id)
#  index_countries_on_name         (name) UNIQUE
#--
# == Schema Information End
#++

class Country < ActiveRecord::Base
  has_many :cities

  validates :name,
            presence: true,
            uniqueness: true
  validates :code,
            presence: true,
            uniqueness: true
end
