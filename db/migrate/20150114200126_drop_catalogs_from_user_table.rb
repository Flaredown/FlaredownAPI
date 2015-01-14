class DropCatalogsFromUserTable < ActiveRecord::Migration
  def change
    remove_column :users, :catalogs
  end
end
