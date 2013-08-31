class Subject < ActiveRecord::Base
  has_many :subject_grades
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
end
