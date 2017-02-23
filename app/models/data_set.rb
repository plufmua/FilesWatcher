class DataSet < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :size, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :absolute_path, presence: true, length: { maximum: 255 }
  validates :creation_time, presence: true
  validates :updating_time, presence: true
  validates :owner, presence: true, length: { maximum: 255 }
  validates :group, presence: true, length: { maximum: 255 }
  validates :permissions, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 777 }
  validate 'valid_creation_time'
  validate 'valid_updating_time'

  def valid_creation_time
    errors.add(:creation_time, "Invalid date of creation") unless creation_time.is_a?(DateTime)
  end

  def valid_updating_time
    errors.add(:updating_time, "Invalid updating date") unless updating_time.is_a?(DateTime)
  end
end
