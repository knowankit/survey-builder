# frozen_string_literal: true

module Api
  module V1
    # This class handles API requests related to responses of survey.
    class ResponsesController < ApplicationController
      def show
        survey = Question.find_by(survey_id: params[:survey_id])
        response = Answer.where(response_id: params[:id])

        render json: { survey:, response: }
      end
    end
  end
end
