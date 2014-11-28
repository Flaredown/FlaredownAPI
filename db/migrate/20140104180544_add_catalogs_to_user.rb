class AddCatalogsToUser < ActiveRecord::Migration
  def change
    add_column :users, :catalogs, :text, array: true, default: []
  end
end
