class CreateScenarios < ActiveRecord::Migration[7.1]
  def change
    create_table :scenarios do |t|
      t.string :name, null: false
      t.string :difficulty, null: false
      t.text :description
      t.text :duration
      t.integer :total_riddles

      t.timestamps
    end

    add_index :scenarios, :name
    add_index :scenarios, :difficulty
  end
end
