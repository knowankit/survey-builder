# frozen_string_literal: true

module Api
  module V1
    # This class handles API requests related to responses of survey.
    class ResponsesController < Api::V1::ApplicationController
      def show
        survey = Survey.includes(questions: :answers).find(params[:survey_id])
        response = Response.find(params[:id])

        questions_with_answers = survey.questions.map do |question|
          answers = response.answers.select { |answer| answer.question_id == question.id }
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

      def get_all_responses
        default_per_page = 10
        default_page = 1
        per_page = params.fetch(:per_page, default_per_page).to_i
        page = params.fetch(:page, default_page).to_i

        responses = Response.includes(:user, :survey).where(user_id: @current_user.id).page(page).per(per_page)

        response_data = responses.map do |response|
          {
            id: response.id,
            user_id: response.user_id,
            survey_id: response.survey_id,
            created_at: response.created_at,
            updated_at: response.updated_at,
            username: response.user.username,
            survey_details: {
              permalink: response.survey.permalink,
            }
          }
        end

        render json: response_data
      end
    end
  end
end
