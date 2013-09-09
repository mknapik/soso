class Language < ActiveRecord::Base
  has_many :countries

  #has_many :language_grades
  #has_many :users, :through => :language_grades
  #has_and_belongs_to_many :committees

  validates :iso_code,
            presence: true,
            uniqueness: true,
            length: {is: 3}
  validates :name,
            presence: true,
            uniqueness: true
end
