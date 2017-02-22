class DataSet < ApplicationRecord
  validates :name, presence: true
  validates :size, presence: true
  validates :route, presence: true
  validates :creating_date, presence: true
  validates :updating_date, presence: true
  validates :owner, presence: true
  validates :group, presence: true
  validates :permissions, presence: true

end
