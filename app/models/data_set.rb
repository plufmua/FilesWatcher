class DataSet < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :size, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :absolute_path, presence: true, length: { maximum: 255 }
  validates :updating_time, presence: true
  validates :owner, presence: true, length: { maximum: 255 }
  validates :group, presence: true, length: { maximum: 255 }
  validates :permissions, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 777 }
  validates :name, uniqueness: { scope: :absolute_path }
end
