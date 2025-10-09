class RiddlesScenario < ApplicationRecord
  belongs_to :scenario
  belongs_to :riddle

  validates :riddle_position, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
