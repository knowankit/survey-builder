# frozen_string_literal: true

module Api
  module V1
    class QuestionOptionsController < Api::V1::ApplicationController
      def index
        question_options = QuestionOption.where(question_id: params[:question_id])

        render json: question_options
      end

      def create
        question_option = QuestionOption.new(question_option_params)
        question_option.user_id = @current_user.id
        question_option.survey_id = params[:survey_id]
        question_option.question_id = params[:question_id]

        if question_option.save
          render json: question_option
        else
          render json: { errors: question_option.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        question_option = Question.find_by(id: params[:question_id], user_id: @current_user.id)

        return unless question_option.destroy

        render json: question_option
      end

      private

      def question_option_params
        params.require(:question_option).permit(:content)
      end
    end
  end
end
