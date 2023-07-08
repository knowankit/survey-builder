# frozen_string_literal: true

module Api
  module V1
    # This class handles API requests related to question answers.
    class AnswersController < ApplicationController
      def create
        ActiveRecord::Base.transaction do
          response = create_response

          params[:answers].each do |answer_params|
            create_answer(answer_params, response)
          end
        end

        render json: { message: 'Answers submitted successfully' }, status: :ok
      rescue ActiveRecord::RecordInvalid => e
        render_validation_error(e.record)
      rescue StandardError => e
        render_error(e)
      end

      private

      def create_response
        Response.create!(user_id: @current_user.id, survey_id: params[:survey_id])
      end

      def create_answer(answer_params, response)
        answer_params = answer_params.permit(:question_id, :content, :question_option_id)
        answer_params = answer_params.merge(
          response_id: response.id,
          user_id: @current_user.id,
          survey_id: params[:survey_id]
        )
        Answer.create!(answer_params)
      end

      def render_validation_error(record)
        error_message = record.errors.full_messages.join(', ')
        render json: { error: "Validation error: #{error_message}" }, status: :unprocessable_entity
      end

      def render_error(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end
    end
  end
end
