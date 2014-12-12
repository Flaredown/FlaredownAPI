class AddActiveSymptomsToUser < ActiveRecord::Migration
  def change
    add_column :users, :active_symptoms, :text, array: true, default: []
  end
end
