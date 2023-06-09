class RemoveUserIdFromSurvey < ActiveRecord::Migration[7.0]
  def change
    remove_column :surveys, :user_id
  end
end
