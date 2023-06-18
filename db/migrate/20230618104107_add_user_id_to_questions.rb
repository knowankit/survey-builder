class AddUserIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :user_id, :bigint
  end
end
