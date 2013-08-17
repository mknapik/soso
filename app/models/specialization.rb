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