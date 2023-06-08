class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.date :last_seen
      t.boolean :is_confirmed
      t.string :role
      t.string :password_digest

      t.timestamps
    end
  end
end
