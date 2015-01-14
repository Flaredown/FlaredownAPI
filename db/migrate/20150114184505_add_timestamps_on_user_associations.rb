class AddTimestampsOnUserAssociations < ActiveRecord::Migration
  def change
    add_column(:conditions, :created_at, :datetime)
    add_column(:conditions, :updated_at, :datetime)
    add_column(:user_conditions, :created_at, :datetime)
    add_column(:user_conditions, :updated_at, :datetime)

    add_column(:symptoms, :created_at, :datetime)
    add_column(:symptoms, :updated_at, :datetime)
    add_column(:user_symptoms, :created_at, :datetime)
    add_column(:user_symptoms, :updated_at, :datetime)

    add_column(:treatments, :created_at, :datetime)
    add_column(:treatments, :updated_at, :datetime)
    add_column(:user_treatments, :created_at, :datetime)
    add_column(:user_treatments, :updated_at, :datetime)
  end
end
