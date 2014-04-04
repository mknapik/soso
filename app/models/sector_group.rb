# == Schema Information
# Schema version: 20130820123421
#
# Table name: sector_groups
#
# *id*::   <tt>integer, not null, primary key</tt>
# *name*:: <tt>string(255), indexed</tt>
#
# Indexes
#
#  index_sector_groups_on_name  (name) UNIQUE
#--
# == Schema Information End
#++

class SectorGroup < ActiveRecord::Base
  has_many :sectors

  validates :name,
            presence: true,
            uniqueness: {case_sensitive: false}
end
