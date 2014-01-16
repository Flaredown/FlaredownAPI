class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :catalog
      t.string :name
      t.string :group
      t.string :kind
      t.integer :section
      t.text :options
      # t.hstore :options, :array => true
            
      t.timestamps
    end
    
    add_index :questions, :name, :unique => true
  end
end
