class Stage < ActiveRecord::Base
  attr_readonly :name

  validates :name,
            presence: true,
            uniqueness: {scope: :committee}
  validates :full_name, :description, :deadline, :committee,
            presence: true

  def self.registration
    Stage.where(name: :register)
  end
end
