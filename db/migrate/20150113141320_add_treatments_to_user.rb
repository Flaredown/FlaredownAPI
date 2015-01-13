class AddTreatmentsToUser < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.string :name, :limit => 50
      t.float :quantity
      t.string :unit, :limit => 20
      t.string :locale, :limit => 2, default: "en"
      t.text :related_catalogs, :array => true, :default => []
    end

    create_table :user_treatments do |t|
      t.belongs_to :user
      t.belongs_to :treatment
    end

    add_column :users, :treatments_count, :integer
    add_column :users, :active_treatments, :text, array: true, default: []

    add_index :treatments, :name, :unique => true
    execute("create index on treatments using gin(to_tsvector('english', name))")

  end
end
