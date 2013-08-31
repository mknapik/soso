# == Schema Information
# Schema version: 20130830122612
#
# Table name: subject_grades
#
# *id*::         <tt>integer, not null, primary key</tt>
# *user_id*::    <tt>integer, indexed</tt>
# *subject_id*:: <tt>integer, indexed</tt>
# *grade*::      <tt>float</tt>
# *ects*::       <tt>float</tt>
# *created_at*:: <tt>datetime</tt>
# *updated_at*:: <tt>datetime</tt>
#
# Indexes
#
#  index_subject_grades_on_subject_id  (subject_id)
#  index_subject_grades_on_user_id     (user_id)
#--
# == Schema Information End
#++

class SubjectGrade < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  validates :grade,
            numericality: {greater_than_or_equal_to: 2, less_than_or_equal_to: 5},
            inclusion: {in: [2, 3, 3.5, 4, 4.5, 5]}

  validates :ects,
            numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 30},
            inclusion: {in: (0.upto(60)).map { |points| points/2.0 }}

  validates :subject_id, :user_id, :grade, :ects,
            presence: true
end

