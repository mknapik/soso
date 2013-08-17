class Faculty < ActiveRecord::Base
  belongs_to :committee
  has_many :users
  has_many :field_of_studies
  has_many :specializations, :through => :field_of_studies

  validates :name,
            presence: true,
            uniqueness: {scope: :committee_id}
  validates :committee_id,
            presence: true
end