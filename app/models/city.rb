# == Schema Information
# Schema version: 20130817211608
#
# Table name: cities
#
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string(255), not null, indexed => [country_id]</tt>
# *country_id*:: <tt>integer, indexed, indexed => [name]</tt>
#
# Indexes
#
#  index_cities_on_country_id           (country_id)
#  index_cities_on_country_id_and_name  (country_id,name) UNIQUE
#--
# == Schema Information End
#++

class City < ActiveRecord::Base
  belongs_to :country
  has_many :committees

  validates :name,
            presence: true,
            uniqueness: {scope: :country_id}
  validates :country_id,
            presence: true,
            numericality: {only_integer: true}
end
