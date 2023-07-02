class AddDefaultValueRequiredQuestionTable < ActiveRecord::Migration[7.0]
  def change
    change_column :questions, :is_required, :boolean, default: false
  end
end
