class RemoveQuantityAndUnitFromTreatments < ActiveRecord::Migration
  def change
    remove_column :treatments, :quantity
    remove_column :treatments, :unit
  end
end
