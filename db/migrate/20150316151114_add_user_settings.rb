class AddUserSettings < ActiveRecord::Migration
  def change
    add_column :users, :settings, :hstore, default: {}
  end
end
