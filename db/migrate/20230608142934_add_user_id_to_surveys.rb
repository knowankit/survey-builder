class AddUserIdToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_reference :surveys, :user, null: false, foreign_key: true
  end
end
