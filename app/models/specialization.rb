# == Schema Information
# Schema version: 20130819143045
#
# Table name: specializations
#
# *id*::                <tt>integer, not null, primary key</tt>
# *name*::              <tt>string(255), indexed => [field_of_study_id]</tt>
# *field_of_study_id*:: <tt>integer, indexed, indexed => [name]</tt>
# *created_at*::        <tt>datetime</tt>
# *updated_at*::        <tt>datetime</tt>
#
# Indexes
#
#  index_specializations_on_field_of_study_id           (field_of_study_id)
#  index_specializations_on_field_of_study_id_and_name  (field_of_study_id,name) UNIQUE
#--
# == Schema Information End
#++

class Specialization < ActiveRecord::Base
  delegate :faculty, to: :field_of_study, allow_nil: true
  belongs_to :field_of_study
  has_many :users

  validates :name,
            presence: true,
            uniqueness: {scope: :field_of_study_id}
  validates :field_of_study_id,
            presence: true
end
