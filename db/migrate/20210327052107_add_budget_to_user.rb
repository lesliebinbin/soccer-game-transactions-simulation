class AddBudgetToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :budget, :decimal, default: Rails.configuration.game.dig(:settings,:user, :budget)
  end
end
