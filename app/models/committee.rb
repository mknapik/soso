# == Schema Information
# Schema version: 20130817211608
#
# Table name: committees
#
# *id*::      <tt>integer, not null, primary key</tt>
# *name*::    <tt>string(255), not null, indexed => [city_id]</tt>
# *code*::    <tt>string(255)</tt>
# *city_id*:: <tt>integer, indexed, indexed => [name]</tt>
#
# Indexes
#
#  index_committees_on_city_id           (city_id)
#  index_committees_on_city_id_and_name  (city_id,name) UNIQUE
#--
# == Schema Information End
#++

class Committee < ActiveRecord::Base
  delegate :country, to: :city, allow_nil: true
  belongs_to :city
  has_many :users
  #has_many :news
  #has_many :faqs
  #has_many :appointment
  has_many :faculties
  has_and_belongs_to_many :languages

  validates :name,
            presence: true,
            uniqueness: {scope: :city_id}
  validates :city_id,
            presence: true,
            numericality: {only_integer: true}
end
