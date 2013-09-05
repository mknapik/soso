# == Schema Information
# Schema version: 20130905143323
#
# Table name: faqs
#
# *id*::           <tt>integer, not null, primary key</tt>
# *question*::     <tt>string(255), not null</tt>
# *answer*::       <tt>text, not null</tt>
# *position*::     <tt>integer</tt>
# *published*::    <tt>boolean, default(FALSE)</tt>
# *public*::       <tt>boolean, default(FALSE)</tt>
# *committee_id*:: <tt>integer</tt>
# *created_at*::   <tt>datetime</tt>
# *updated_at*::   <tt>datetime</tt>
#--
# == Schema Information End
#++

class Faq < ActiveRecord::Base
  belongs_to :committee

  acts_as_list

  validates :question,
            presence: true
  validates :answer,
            presence: true
  validates :committee,
            presence: true

  default_scope order: :position
end
