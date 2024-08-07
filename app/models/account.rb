class Account < ApplicationRecord
  has_many :users
  has_many :resources
  has_many :schedule_categories

  has_many :bookings, through: :users

  validates :name, presence: true
  validates :email, presence: true
end
