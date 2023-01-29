class CreateSpreeDeposits < ActiveRecord::Migration[7.0]
  def up
    create_table :spree_deposits do |t|
      t.integer :user_id
      t.decimal :amount, precision: 10, scale: 2, default: "0.0"
      t.datetime :deposit_date
      t.string :description
      t.timestamps
    end
  end

  def down
    drop_table :spree_deposits
  end
end
