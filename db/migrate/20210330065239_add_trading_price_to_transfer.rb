class AddTradingPriceToTransfer < ActiveRecord::Migration[5.2]
  def change
    add_column :transfers, :trading_price, :decimal
  end
end
