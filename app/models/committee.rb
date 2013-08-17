class Committee < ActiveRecord::Base
  belongs_to :city
  has_many :users
  #has_many :news
  #has_many :faqs
  #has_many :appointment
  #has_many :faculties
  #has_and_belongs_to_many :languages, join_table: 'languages_committees'

  validates :name, presence: true, uniqueness: {scope: :city_id}
  validates :city_id, presence: true, numericality: {only_integer: true}
end
