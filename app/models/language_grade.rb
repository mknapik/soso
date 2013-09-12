# == Schema Information
# Schema version: 20130911142514
#
# Table name: language_grades
#
# *id*::          <tt>integer, not null, primary key</tt>
# *user_id*::     <tt>integer, indexed => [language_id], indexed => [language_id, year], indexed</tt>
# *language_id*:: <tt>integer, indexed, indexed => [user_id], indexed => [user_id, year]</tt>
# *grade*::       <tt>float</tt>
# *year*::        <tt>integer, indexed => [language_id, user_id]</tt>
# *paid*::        <tt>boolean</tt>
# *created_at*::  <tt>datetime</tt>
# *updated_at*::  <tt>datetime</tt>
#
# Indexes
#
#  index_language_grades_on_language_id                       (language_id)
#  index_language_grades_on_language_id_and_user_id           (language_id,user_id)
#  index_language_grades_on_language_id_and_user_id_and_year  (language_id,user_id,year) UNIQUE
#  index_language_grades_on_user_id                           (user_id)
#--
# == Schema Information End
#++

class LanguageGrade < ActiveRecord::Base
  # +year+ is always set to +Setting.year+
  # +user_id+, +language_id+ and +year+ cannot be +NULL+
  #
  # Only one language per user per year is possible.
  #
  # If +grade = nil+ then entity is a sign up for an exam
  # otherwise it is a grade for written exam.
  belongs_to :user
  belongs_to :language

  validates :grade,
            numericality: {greater_than_or_equal_to: 2, less_than_or_equal_to: 5},
            allow_blank: true
  validates :year,
            uniqueness: {scope: [:language_id, :user_id]}
  validates :user_id, :language_id, :year,
            presence: true

  def self.has_paid user_id
    user = User.find(user_id)
    not LanguageGrade.where(user_id: user.id, paid: true, year: Setting.year(user.committee_id)).empty?
  end

  def self.has_selected(user_id)
    user = User.find(user_id)
    not LanguageGrade.where(user_id: user.id, grade: nil, year: Setting.year(user.committee_id)).empty?
  end
end
