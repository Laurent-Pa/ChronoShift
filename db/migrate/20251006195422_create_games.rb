class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :score
      t.boolean :is_finished
      t.integer :duration
      t.datetime :ends_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
