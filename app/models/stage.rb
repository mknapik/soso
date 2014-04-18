# == Schema Information
# Schema version: 20130905143323
#
# Table name: stages
#
# *id*::           <tt>integer, not null, primary key</tt>
# *name*::         <tt>string(255), not null, indexed => [committee_id]</tt>
# *full_name*::    <tt>string(255), not null</tt>
# *description*::  <tt>text, not null</tt>
# *deadline*::     <tt>datetime, not null</tt>
# *committee_id*:: <tt>integer, indexed, indexed => [name]</tt>
# *created_at*::   <tt>datetime</tt>
# *updated_at*::   <tt>datetime</tt>
#
# Indexes
#
#  index_stages_on_committee_id           (committee_id)
#  index_stages_on_committee_id_and_name  (committee_id,name) UNIQUE
#--
# == Schema Information End
#++

class Stage < ActiveRecord::Base
  attr_readonly :name
  belongs_to :committee

  validates :name,
            presence: true,
            uniqueness: {scope: :committee_id, case_sensitive: false}
  validates :full_name, :description, :deadline, :committee,
            presence: true

  def self.registration
    Stage.where(name: :register)
  end
end
