class CreateQuestionInputs < ActiveRecord::Migration
  def change
    create_table :question_inputs do |t|
      t.integer :question_id
      t.integer :value
      t.string :label
      t.string :meta_label
      t.string :helper
    end
  end
end
