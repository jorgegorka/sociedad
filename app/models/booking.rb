class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :schedule_category

  validates :start_on, presence: true

  after_create :assign_end_on

  private

  def assign_end_on
    self.end_on = start_on if end_on.blank?
    save
  end
end
