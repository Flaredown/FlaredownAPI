class AddUserConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :name, :limit => 100
      t.string :locale, :limit => 2, default: "en"
    end

    create_table :user_conditions do |t|
      t.belongs_to :user
      t.belongs_to :condition
    end

    add_column :users, :conditions_count, :integer
    add_column :users, :active_conditions, :text, array: true, default: []

    add_index :conditions, :name, :unique => true
    execute("create index on treatments using gin(to_tsvector('english', name))")
  end
end
