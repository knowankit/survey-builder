class Api::V1::AnswersController < ApplicationController
  belongs_to :response
  belongs_to :question
  belongs_to :question_option, optional: true
end
