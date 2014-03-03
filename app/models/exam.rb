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

  has_many :language_grades
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

  def self.available(user)
    user_id, committee_id = user.id, user.committee_id

    Exam.
        joins(:language => :language_grades).
        includes(:language).
        includes(:language_grades).
        where(language_grades: {user_id: user_id, grade: nil, year: Setting.year(committee_id), paid: true},
              exams: {committee_id: committee_id, state: :open})
  end

  def places
    # .size instead of .count because :language_grades are included in join
    places = {min: self.min, max: self.max, occupied: self.language_grades.size}
    places[:left] = places[:max] - places[:occupied]
    places
  end

  def calendar_event
    {
        id: self.id,
        language_name: self.language.try(:name),
        language_id: self.language_id,
        start: self.datetime.to_i,
        end: (self.datetime + 1.hour).to_i,
        places: self.places
    }
  end

  def places_left
    self.max - self.language_grades.count
  end

  def signed_up?(user_id)
    user_id = user_id.id if user_id.is_a? User

    self.language_grades.includes(:user).where(user_id: user_id).count > 0
  end
end
