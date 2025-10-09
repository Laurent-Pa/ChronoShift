class CreateRiddlesScenarios < ActiveRecord::Migration[7.1]
  def change
    create_table :riddles_scenarios do |t|
      t.references :scenario, null: false, foreign_key: true
      t.references :riddle, null: false, foreign_key: true
      t.integer :riddle_position

      t.timestamps
    end
  end
end
