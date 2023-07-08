# frozen_string_literal: true

module Api
  module V1
    # This class handles API requests related to question answers.
    class AnswersController < ApplicationController
      def create
        begin
          ActiveRecord::Base.transaction do
            response = Response.new(user_id: @current_user.id, survey_id: params[:survey_id])
            response.save!

            answers = params[:answers]

            answers.each do |answer_params|
              answer = Answer.new(answer_params.permit(:question_id, :content, :question_option_id).merge(response_id: response.id, user_id: @current_user.id, survey_id: params[:survey_id]))
              answer.save!
            end
          end

          render json: { message: 'Answers submitted successfully' }, status: :ok
        rescue ActiveRecord::RecordInvalid => e
          error_message = e.record.errors.full_messages.join(', ')
          render json: { error: "Validation error: #{error_message}" }, status: :unprocessable_entity
        rescue StandardError => e
          render json: { error: e.message }, status: :unprocessable_entity
        end
      end
    end
  end
end
