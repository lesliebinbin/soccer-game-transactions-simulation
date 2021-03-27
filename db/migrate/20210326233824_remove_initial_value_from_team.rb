class RemoveInitialValueFromTeam < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :initial_value, :decimal
  end
end
