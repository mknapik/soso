# == Schema Information
# Schema version: 20130819143045
#
# Table name: field_of_studies
#
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string(255), indexed => [faculty_id]</tt>
# *faculty_id*:: <tt>integer, indexed, indexed => [name]</tt>
# *created_at*:: <tt>datetime</tt>
# *updated_at*:: <tt>datetime</tt>
#
# Indexes
#
#  index_field_of_studies_on_faculty_id           (faculty_id)
#  index_field_of_studies_on_faculty_id_and_name  (faculty_id,name) UNIQUE
#--
# == Schema Information End
#++

class FieldOfStudy < ActiveRecord::Base
  belongs_to :faculty
  has_many :specializations
  has_many :users

  validates :name,
            presence: true,
            uniqueness: {scope: :faculty_id}
  validates :faculty_id,
            presence: true
end
