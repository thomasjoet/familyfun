class Reading < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :grade, presence: true
  validates :grade, numericality: { :greater_than_or_equal_to: 0 }
  validates :grade, numericality: { :less_than_or_equal_to: 5 }
  validates :comment, presence: true, length: { maximum: 140 }
end
