class AddIsAnsweredColumnToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :is_answered, :boolean, default: false

    Question.update_all(is_answered: false)
  end
end
