class AddCourseConfirmedToSpreeProducts < ActiveRecord::Migration[7.0]

  def change
    add_column :spree_products, :course_confirmed, :boolean, default: false
  end

end