class Resource < ApplicationRecord
  belongs_to :account

  has_one_attached :photo

  validates :name, presence: true
end
