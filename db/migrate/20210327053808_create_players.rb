class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.integer :age
      t.string :first_name
      t.string :last_name
      t.decimal :market_value
      t.string :country
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
