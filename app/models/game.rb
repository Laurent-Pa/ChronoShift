class Game < ApplicationRecord
  belongs_to :user
  belongs_to :scenario

  validates :scenario_id, presence: true

  # La durée est déterminée par le scénario
  def duration
    scenario.duration
  end

end
