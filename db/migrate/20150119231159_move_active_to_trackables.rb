class MoveActiveToTrackables < ActiveRecord::Migration
  def change
    remove_column :users, :active_conditions
    remove_column :users, :active_treatments
    remove_column :users, :active_symptoms

    add_column :user_conditions, :active, :boolean
    add_column :user_treatments, :active, :boolean
    add_column :user_symptoms, :active, :boolean
  end
end
