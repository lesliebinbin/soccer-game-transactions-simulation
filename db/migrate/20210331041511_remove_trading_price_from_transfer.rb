class RemoveTradingPriceFromTransfer < ActiveRecord::Migration[6.1]
  def change
    remove_column :transfers, :trading_price, :decimal
  end
end
