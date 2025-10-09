class CreateScenarios < ActiveRecord::Migration[7.1]
  def change
    create_table :scenarios do |t|
      t.string :name, null: false
      t.text :description
      t.integer :difficulty, default: 0
      t.integer :duration, default: 5 # en minutes
      t.integer :total_riddles, null: false

      t.timestamps
    end

    add_index :scenarios, :name
  end
end
