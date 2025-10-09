class AddScenarioToGames < ActiveRecord::Migration[7.1]
  def change
    add_reference :games, :scenario, null: false, foreign_key: true
  end
end
