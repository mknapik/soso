class City < ActiveRecord::Base
  belongs_to :country
  has_many :committees

  validates :name,
            presence: true,
            uniqueness: {scope: :country_id}
  validates :country_id,
            presence: true,
            numericality: {only_integer: true}
end
