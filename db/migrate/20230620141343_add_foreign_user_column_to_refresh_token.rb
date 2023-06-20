class AddForeignUserColumnToRefreshToken < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :refresh_tokens, :users
  end
end
