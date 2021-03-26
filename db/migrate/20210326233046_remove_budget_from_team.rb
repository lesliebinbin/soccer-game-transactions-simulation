class RemoveBudgetFromTeam < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :budget, :integer
  end
end
