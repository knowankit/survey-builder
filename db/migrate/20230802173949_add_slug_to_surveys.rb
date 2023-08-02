class AddSlugToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :slug, :string
    add_index :surveys, :slug, unique: true
  end
end
