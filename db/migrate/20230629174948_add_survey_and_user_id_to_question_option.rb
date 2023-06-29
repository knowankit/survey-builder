class AddSurveyAndUserIdToQuestionOption < ActiveRecord::Migration[7.0]
  def change
    add_reference :question_options, :user, null: false, foreign_key: true
    add_reference :question_options, :survey, null: false, foreign_key: true
  end
end
