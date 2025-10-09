class Scenario < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :riddles_scenarios, -> { order(riddle_position: :asc) }, dependent: :destroy
  has_many :riddles, through: :riddles_scenarios

  validates :theme, presence: true
end
