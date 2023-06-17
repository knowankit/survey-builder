class AddPermalinkUniquessToSurvey < ActiveRecord::Migration[7.0]
  def change
    change_column :surveys, :permalink, :string, unique: true
  end
end
