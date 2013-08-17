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
