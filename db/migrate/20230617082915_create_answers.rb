class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.references :response, foreign_key: true
      t.references :survey, foreign_key: true
      t.references :question_option, foreign_key: true
      t.timestamps
    end
  end
end
