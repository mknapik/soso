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

  def self.stage(committee)
    committee_id = committee_to_id(committee)
    @@cache[:stage][committee_id] ||=
        Stage.find(Setting.find_by!(committee_id: committee_id, year: self.year(committee_id), name: :stage).value.to_i)
  end

  def self.stage=(value)
    raise ArgumentError.new('Provide `[committee, stage]` as a value!') unless value.is_a?(Array)
    committee_id, new_stage = value
    new_stage = Stage.find_by!(name: new_stage, committee_id: committee_id) unless new_stage.is_a? Stage

    @@cache[:stage] = Hash.new
    setting = Setting.where(committee_id: committee_id, year: self.year(committee_id), name: :stage).first_or_initialize
    setting.value = new_stage.id
    setting.save
  end

  def self.year(committee)
    committee_id = committee_to_id(committee)

    @@cache[:year][committee_id] ||=
        Setting.find_by!(committee_id: committee_id, year: 0, name: :year).value.to_i
  end

  def self.year=(value)
    raise ArgumentError.new('Provide `[committee, year]` as a value!') unless value.is_a?(Array)
    committee_id, new_year = value
    raise ArgumentError.new('Provided `year` is not a number!') unless new_year.is_a? Numeric

    @@cache[:year] = Hash.new
    setting = Setting.where(committee_id: committee_id, year: 0, name: :year).first_or_initialize
    setting.value = new_year
    setting.save
  end

  protected

  def self.committee_to_id(committee)
    if committee.is_a? Committee
      committee.id
    else
      committee
    end
  end
end
