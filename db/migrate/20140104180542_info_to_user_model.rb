class InfoToUserModel < ActiveRecord::Migration
  def change
  	add_column :users, :gender, :string
  	add_column :users, :weight, :integer
  end
end
