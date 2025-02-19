class Account < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :resources, dependent: :destroy
  has_many :schedule_categories, dependent: :destroy

  has_many :bookings, through: :users

  validates :name, presence: true
  validates :email, presence: true
end
