class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
		t.integer :stools 
		t.integer :ab_pain
		t.integer :general
		t.boolean :complication_arthritis
		t.boolean :complication_iritis
		t.boolean :complication_erythema
		t.boolean :complication_fistula
		t.boolean :complication_other_fistula
		t.boolean :complication_fever
		t.integer :opiates
		t.integer :mass
		t.integer :hematocrit
		t.integer :weight_current
		
    	t.timestamps
    end
  end
end
