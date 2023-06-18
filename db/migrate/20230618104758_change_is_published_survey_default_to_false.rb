class ChangeIsPublishedSurveyDefaultToFalse < ActiveRecord::Migration[7.0]
  def change
    change_column :surveys, :is_published, :boolean, default: false
  end
end
