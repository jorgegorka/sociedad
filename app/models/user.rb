class User < ApplicationRecord
  has_secure_password

  REGULAR = 'regular'.freeze
  ADMIN = 'admin'.freeze
  SUPERADMIN = 'superadmin'.freeze

  belongs_to :account

  validates :username, presence: true, uniqueness: true, length: { in: 3..15 },
                       format: {
                         with: /\A[a-z0-9A-Z]+\z/,
                         message: :invalid
                       }
  validates :email, format: {
    with: /\A([\w+-].?)+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: :invalid
  }

  enum role: { regular: 0, admin: 9, superadmin: 99 }

  before_save :downcase_attributes

  def assign_forget_attributes
    self.forget_token = SecureRandom.hex(32)
    self.forget_expires_at = 4.hours.from_now
  end

  private

  def downcase_attributes
    self.username = username.downcase
    self.email = email&.downcase
  end
end
