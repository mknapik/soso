class Stage < ActiveRecord::Base
  attr_readonly :name

  validates :name,
            presence: true,
            uniqueness: true
  validates :full_name,
            presence: true
  validates :description,
            presence: true
  validates :deadline,
            presence: true

  def self.registration
    Stage.where(name: :register)
  end
end
