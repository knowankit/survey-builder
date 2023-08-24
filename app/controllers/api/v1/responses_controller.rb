# frozen_string_literal: true

module Api
  module V1
    # This class handles API requests related to responses of survey.
    class ResponsesController < ApplicationController
      def show
        # survey = Question.find_by(survey_id: params[:survey_id])
        # response = Answer.where(response_id: params[:id])

        # render json: { response: }

        survey = Survey.find(params[:survey_id])
        response = Response.find(params[:id])

        questions_with_answers = survey.questions.map do |question|
          answers = response.answers.where(question_id: question.id)
          {
            question: question,
            answers: answers
          }
        end

        render json: questions_with_answers
      end

      def index
        default_per_page = 10
        default_page = 1
        per_page = params.fetch(:per_page, default_per_page).to_i
        page = params.fetch(:page, default_page).to_i

        responses = Response.where(user_id: @current_user.id).page(page).per(per_page)

        render json: { responses:, page:, per_page: }
      end
    end
  end
end
