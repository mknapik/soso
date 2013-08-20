# == Schema Information
# Schema version: 20130820122039
#
# Table name: sectors
#
# *id*::              <tt>integer, not null, primary key</tt>
# *name*::            <tt>string(255), indexed => [sector_group_id]</tt>
# *sector_group_id*:: <tt>integer, indexed, indexed => [name]</tt>
#
# Indexes
#
#  index_sectors_on_sector_group_id           (sector_group_id)
#  index_sectors_on_sector_group_id_and_name  (sector_group_id,name) UNIQUE
#--
# == Schema Information End
#++

class Sector < ActiveRecord::Base
  belongs_to :sector_group
  has_many :sector_priorities
  has_many :users, through: :sector_priorities

  validates :name,
            presence: true,
            uniqueness: {scope: :sector_group_id, :case_sensitive => false}

  validates :sector_group_id,
            presence: true
end
