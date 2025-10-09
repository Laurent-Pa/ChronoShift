class CreateRiddles < ActiveRecord::Migration[7.1]
  def change
    create_table :riddles do |t|
      t.string :title
      t.string :theme
      t.text :question
      t.text :answer
      t.text :hint
      t.text :lesson

      t.timestamps
    end
  end
end
