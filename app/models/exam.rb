# == Schema Information
# Schema version: 20131010090254
#
# Table name: exams
#
# *id*::           <tt>integer, not null, primary key</tt>
# *language_id*::  <tt>integer, indexed</tt>
# *datetime*::     <tt>datetime</tt>
# *min*::          <tt>integer</tt>
# *max*::          <tt>integer</tt>
# *state*::        <tt>string(255)</tt>
# *committee_id*:: <tt>integer, indexed</tt>
# *created_at*::   <tt>datetime</tt>
# *updated_at*::   <tt>datetime</tt>
#
# Indexes
#
#  index_exams_on_committee_id  (committee_id)
#  index_exams_on_language_id   (language_id)
#--
# == Schema Information End
#++

class Exam < ActiveRecord::Base
  @@states = [:open, :close, :canceled, :confirmed]

  has_and_belongs_to_many :language_grades
  belongs_to :committee
  belongs_to :language

  validates :committee,
            presence: true
  validates :language,
            presence: true
  validates :state,
            presence: true,
            #numericality: {only_integer: true, message: I18n.t(:only_integer)},
            inclusion: {in: @@states}
  validates :min,
            presence: true,
            numericality: {only_integer: true, less_than_or_equal_to: :max}
  validates :max,
            presence: true,
            numericality: {only_integer: true, greater_than_or_equal_to: :max}

  def name
    if self.language
      self.language.name+', '+self.datetime.strftime('%d.%m %H:%M')
    else
      self.datetime.strftime('%d.%m %H:%M')
    end
  end

  def state
    read_attribute(:state).to_sym
  end

  def state=(value)
    write_attribute(:state, value.to_s)
  end

  def self.available(user_id, committee_id=nil)
    if committee_id.nil?
      raise ArgumentError, "'committee_id=nil' and first argument is not a User" unless user_id.is_a? ActiveRecord::Base
      user_id, committee_id = user_id.id, user_id.committee_id
    end

    Exam.
        joins(:language => :language_grades).
        includes(:language).
        where(language_grades: {user_id: user_id, grade: nil, year: Setting.year(committee_id), paid: true},
              exams: {committee_id: committee_id, state: :open})
  end
end
