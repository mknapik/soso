# == Schema Information
# Schema version: 20130830122612
#
# Table name: subjects
#
# *id*::           <tt>integer, not null, primary key</tt>
# *name*::         <tt>string(255), indexed => [committee_id]</tt>
# *committee_id*:: <tt>integer, indexed, indexed => [name]</tt>
# *created_at*::   <tt>datetime</tt>
# *updated_at*::   <tt>datetime</tt>
#
# Indexes
#
#  index_subjects_on_committee_id           (committee_id)
#  index_subjects_on_committee_id_and_name  (committee_id,name) UNIQUE
#--
# == Schema Information End
#++

class Subject < ActiveRecord::Base
  has_many :subject_grades, dependent: :delete_all
  has_many :users, through: :subject_grades
  belongs_to :committee

  validates :name,
            uniqueness: {scope: :committee, case_sensitive: false},
            allow_blank: true
  validates :name, :committee,
            presence: true

  def self.get phrase
    # subject found by same name
    Subject.where('UPPER(name) = UPPER(?)', phrase).first_or_create!
  end

  def self.find_or_create(subject_id, subject_name=nil, committee_id=nil)
    if subject_id.blank?
      unless subject_name.blank?
        Subject.where('UPPER(name) = UPPER(?) AND committee_id = ?',
                      subject_name, committee_id).first ||
            Subject.create!(name: subject_name, committee_id: committee_id)
      end ||
          Subject.new(committee_id: committee_id)
    else
      Subject.find(subject_id)
    end
  end
end
