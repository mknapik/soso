class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  validates :name,
            presence: true,
            length: { maximum: 30 }

  validates :email,
            presence: true,
            email: true,
            uniqueness: true

  validates :password,
            presence: true,
            length: { minimum: 6 },
            if: :password
end
