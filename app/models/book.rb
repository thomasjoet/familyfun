class Book < ActiveRecord::Base
  has_many :readings
  validates :title, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  validates :author, presence: true
  validates :category, presence: true
end
