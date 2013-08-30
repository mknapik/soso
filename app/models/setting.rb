class Setting < ActiveRecord::Base
  attr_readonly :name

  validates :name,
            presence: true,
            uniqueness: {scope: :year}

  validates :value,
            presence: true

  validates :year,
            presence: true

  def self.stage
    Stage.find(Setting.where(year: self.year, name: :stage).first.value)
  end

  def self.stage=(new_stage)
    setting = Setting.where(year: self.year, name: :stage)
    setting.value = new_stage
    setting.save
  end

  def self.year
    year = Setting.where(year: 0, name: :year).first
    return Date.current.year if year.nil?
    year.value
  end

  def self.year=(new_year)
    setting = Setting.where(year: 0, name: :year).first_or_initialize
    setting.value = new_year
    setting.save
  end

end
