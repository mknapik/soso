class Country < ActiveRecord::Base
  has_many :cities

  validates :name,
            presence: true,
            uniqueness: true
  validates :code,
            presence: true,
            uniqueness: true
end
