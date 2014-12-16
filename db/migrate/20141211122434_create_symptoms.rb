class CreateSymptoms < ActiveRecord::Migration
  def change
    create_table :symptoms do |t|
      t.string :name, :limit => 50
      t.string :language, :limit => 2
      t.text :related_catalogs, :array => true, :default => []
    end

    create_table :user_symptoms do |t|
      t.belongs_to :user
      t.belongs_to :symptom
    end

    add_index :symptoms, :name, :unique => true
    execute("create index on symptoms using gin(to_tsvector('english', name))")

  end
end
