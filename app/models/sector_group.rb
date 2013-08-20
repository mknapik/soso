# == Schema Information
# Schema version: 20130820121315
#
# Table name: sector_groups
#
# *id*:: <tt>integer, not null, primary key</tt>
#--
# == Schema Information End
#++

class SectorGroup < ActiveRecord::Base
  has_many :sectors

  validates :name,
            presence: true,
            uniqueness: {:case_sensitive => false}
end
