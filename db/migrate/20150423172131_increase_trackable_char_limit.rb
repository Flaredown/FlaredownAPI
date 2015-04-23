class IncreaseTrackableCharLimit < ActiveRecord::Migration
  def change
    change_column :symptoms, :name, :string, limit: 100
    change_column :treatments, :name, :string, limit: 100
  end
end
