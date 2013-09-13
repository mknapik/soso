# == Schema Information
# Schema version: 20130905143323
#
# Table name: settings
#
# *id*::           <tt>integer, not null, primary key</tt>
# *name*::         <tt>string(255), not null, indexed => [committee_id, year]</tt>
# *value*::        <tt>string(255), not null</tt>
# *year*::         <tt>integer, not null, indexed => [committee_id, name]</tt>
# *committee_id*:: <tt>integer, indexed, indexed => [year, name]</tt>
# *created_at*::   <tt>datetime</tt>
# *updated_at*::   <tt>datetime</tt>
#
# Indexes
#
#  index_settings_on_committee_id                    (committee_id)
#  index_settings_on_committee_id_and_year_and_name  (committee_id,year,name) UNIQUE
#--
# == Schema Information End
#++

class Setting < ActiveRecord::Base
  attr_readonly :name
  belongs_to :committee

  validates :name,
            presence: true,
            uniqueness: {scope: [:committee, :year], case_sensitive: false}

  validates :value, :year, :committee,
            presence: true

  @@cache = {stage: Hash.new, year: Hash.new}

  def self.stage(committee_id)
    @@cache[:stage][committee_id] || (@@cache[:stage][committee_id] = Stage.find(Setting.find(committee_id: committee_id, year: self.year(committee_id), name: :stage).value))
  end

  def self.stage=(value)
    committee_id, new_stage = value
    setting = Setting.find(committee_id: committee_id, year: self.year(committee_id), name: :stage)
    setting.value = new_stage
    setting.save
    @@cache[:stage] = Hash.new
  end

  def self.year(committee_id)
    @@cache[:year][committee_id] || (@@cache[:year][committee_id] = begin
      year = Setting.where(committee_id: committee_id, year: 0, name: :year).first
      if year.nil?
        Date.current.year
      else
        year.value
      end
    end)
  end

  def self.year=(value)
    #raise 'a' unless value.is_a?( Array )
    committee_id, new_year = value
    setting = Setting.where(committee_id: committee_id, year: 0, name: :year).first_or_initialize
    setting.value = new_year
    setting.save
    @@cache[:year] = Hash.new
  end

end
