class Account < ApplicationRecord
  has_many :users
  
  validates :name, presence: true
  validates :email, presence: true
end
