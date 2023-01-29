class ChangeFieldsFromSpreeProducts < ActiveRecord::Migration[5.2]
    def change
        remove_column :spree_products, :date, :datetime
        remove_column :spree_products, :time, :datetime
        change_column :spree_products, :date_and_time, :datetime, :precision => 6
    end
end
  