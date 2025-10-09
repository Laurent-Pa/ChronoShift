class CreateScenarios < ActiveRecord::Migration[7.1]
   def change
    create_table :scenarios do |t|
      t.string :name, null: false
      t.string :theme, null: false  # ← Ajout du thème
      t.string :difficulty, null: false
      t.text :description

      t.timestamps
    end

    add_index :scenarios, :theme
    add_index :scenarios, :difficulty
  end
end
