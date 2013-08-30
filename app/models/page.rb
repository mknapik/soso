# == Schema Information
# Schema version: 20130830004029
#
# Table name: pages
#
# *id*::         <tt>integer, not null, primary key</tt>
# *slug*::       <tt>string(255), not null, indexed</tt>
# *title*::      <tt>string(255), not null</tt>
# *public*::     <tt>boolean, default(TRUE)</tt>
# *content*::    <tt>text</tt>
# *created_at*:: <tt>datetime</tt>
# *updated_at*:: <tt>datetime</tt>
#
# Indexes
#
#  index_pages_on_slug  (slug) UNIQUE
#--
# == Schema Information End
#++

class Page < ActiveRecord::Base
  validates :slug,
            presence: true,
            uniqueness: true

  validates :title,
            presence: true
end
