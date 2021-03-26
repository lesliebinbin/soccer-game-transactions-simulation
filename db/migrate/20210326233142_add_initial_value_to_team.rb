class AddInitialValueToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :initial_value, :decimal
  end
end
