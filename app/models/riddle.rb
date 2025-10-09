class Riddle < ApplicationRecord
  has_many :riddles_scenarios, dependent: :destroy
  has_many :scenarios, through: :riddles_scenarios

  validates :title, :question, :answer, presence: true
end
