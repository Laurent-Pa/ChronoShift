class AddElapsedTimeToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :elapsed_time, :integer
  end
end
