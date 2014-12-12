class AddSymptomsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :symptoms_count, :integer
  end
end
