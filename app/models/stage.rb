# == Schema Information
# Schema version: 20130902135412
#
# Table name: stages
#
# *id*::          <tt>integer, not null, primary key</tt>
# *name*::        <tt>string(255), not null, indexed</tt>
# *full_name*::   <tt>string(255), not null</tt>
# *description*:: <tt>text, not null</tt>
# *deadline*::    <tt>datetime, not null</tt>
# *created_at*::  <tt>datetime</tt>
# *updated_at*::  <tt>datetime</tt>
#
# Indexes
#
#  index_stages_on_name  (name) UNIQUE
#--
# == Schema Information End
#++

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
