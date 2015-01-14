class UserAndSymptomsTweaks < ActiveRecord::Migration
  def change
    rename_column :symptoms, :language, :locale
    remove_column :users, :weight
    remove_column :users, :gender
  end
end
