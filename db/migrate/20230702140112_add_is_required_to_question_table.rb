class AddIsRequiredToQuestionTable < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :is_required, :boolean
  end
end
