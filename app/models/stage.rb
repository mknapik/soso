class Stage < ActiveRecord::Base
  attr_readonly :name
  belongs_to :committee

  validates :name,
            presence: true,
            uniqueness: {scope: :committee, case_sensitive: false}
  validates :full_name, :description, :deadline, :committee,
            presence: true

  def self.registration
    Stage.where(name: :register)
  end
end
