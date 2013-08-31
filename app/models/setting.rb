class Setting < ActiveRecord::Base
  attr_readonly :name
  belongs_to :committee

  validates :name,
            presence: true,
            uniqueness: {scope: [:committee, :year], case_sensitive: false}

  validates :value, :year, :committee,
            presence: true

  def self.stage(committee_id)
    Stage.find(Setting.where(committee_id: committee_id, year: self.year(committee_id), name: :stage).first.value)
  end

  def self.stage=(committee_id, new_stage)
    setting = Setting.where(committee_id: committee_id, year: self.year(committee_id), name: :stage)
    setting.value = new_stage
    setting.save
  end

  def self.year(committee_id)
    year = Setting.where(committee_id: committee_id, year: 0, name: :year).first
    return Date.current.year if year.nil?
    year.value
  end

  def self.year=(committee_id, new_year)
    setting = Setting.where(committee_id: committee_id, year: 0, name: :year).first_or_initialize
    setting.value = new_year
    setting.save
  end

end
