class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
      t.datetime :submitted_at
      t.references :user, foreign_key: true
      t.references :survey, foreign_key: true


      t.timestamps
    end
  end
end
