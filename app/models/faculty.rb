# == Schema Information
# Schema version: 20130819143045
#
# Table name: faculties
#
# *id*::           <tt>integer, not null, primary key</tt>
# *name*::         <tt>string(255), indexed => [committee_id]</tt>
# *committee_id*:: <tt>integer, indexed, indexed => [name]</tt>
# *created_at*::   <tt>datetime</tt>
# *updated_at*::   <tt>datetime</tt>
#
# Indexes
#
#  index_faculties_on_committee_id           (committee_id)
#  index_faculties_on_committee_id_and_name  (committee_id,name) UNIQUE
#--
# == Schema Information End
#++

class Faculty < ActiveRecord::Base
  belongs_to :committee
  has_many :users
  has_many :field_of_studies
  has_many :specializations, :through => :field_of_studies

  validates :name,
            presence: true,
            uniqueness: {scope: :committee_id}
  validates :committee_id,
            presence: true
end
