class AddOnTradeToPlayer < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :on_trade, :boolean, default: false
  end
end
