class AddColumnsSurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :user_id, :string, default: nil
    add_column :surveys, :is_published, :boolean, default: false

    Survey.update_all(user_id: nil)
    Survey.update_all(is_published: false)
  end
end
