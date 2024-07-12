class Account < ApplicationRecord
  has_many :users
  has_many :resources

  validates :name, presence: true
  validates :email, presence: true
end
