class AddThemeToScenarios < ActiveRecord::Migration[7.1]
  def change
    add_column :scenarios, :theme, :string
  end
end
