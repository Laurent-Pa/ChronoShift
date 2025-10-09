class RemoveNameFromScenarios < ActiveRecord::Migration[7.1]
  def change
    remove_column :scenarios, :name, :string
  end
end
