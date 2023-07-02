class AddDefaultValueToQuestions < ActiveRecord::Migration[7.0]
  def change
    change_column :questions, :is_required, :boolean, default: false

    Question.update_all(is_required: false)
  end
end
