# == Schema Information
# Schema version: 20130820123421
#
# Table name: sector_priorities
#
# *id*::         <tt>integer, not null, primary key</tt>
# *priority*::   <tt>integer, indexed => [user_id]</tt>
# *sector_id*::  <tt>integer, indexed, indexed => [user_id]</tt>
# *user_id*::    <tt>integer, indexed, indexed => [priority], indexed => [sector_id]</tt>
# *created_at*:: <tt>datetime</tt>
# *updated_at*:: <tt>datetime</tt>
#
# Indexes
#
#  index_sector_priorities_on_sector_id              (sector_id)
#  index_sector_priorities_on_user_id                (user_id)
#  index_sector_priorities_on_user_id_and_priority   (user_id,priority) UNIQUE
#  index_sector_priorities_on_user_id_and_sector_id  (user_id,sector_id) UNIQUE
#--
# == Schema Information End
#++

class SectorPriority < ActiveRecord::Base
  belongs_to :sector
  belongs_to :user

  validates :sector_id,
            uniqueness: {scope: :user_id}

  validates :sector_id, :user_id,
            presence: true

  validates :priority,
            presence: true,
            uniqueness: {scope: :user_id}
end
