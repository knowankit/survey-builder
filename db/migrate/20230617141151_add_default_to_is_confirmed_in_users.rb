class AddDefaultToIsConfirmedInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :is_confirmed, :boolean, default: false
  end
end
