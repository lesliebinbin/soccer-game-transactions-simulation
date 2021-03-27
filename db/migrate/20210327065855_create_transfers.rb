class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.references :seller, foreign_key: {to_table: 'users'}
      t.references :buyer, foreign_key: {to_table: 'users'}
      t.references :player, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
