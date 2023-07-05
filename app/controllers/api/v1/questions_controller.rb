# frozen_string_literal: true

module Api
  module V1
    # This class handles API requests related to question.
    class QuestionsController < Api::V1::ApplicationController
      before_action :authenticate_user

      def index
        questions = Question.where(survey_id: params[:survey_id], user_id: @current_user.id) || []

        render json: questions
      end

      def create
        question = Question.new(question_params)
        question.user_id = @current_user.id
        question.survey_id = params[:survey_id]

        if question.save
          render json: question
        else
          render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        question = find_question

        return render_question_not_found unless question

        if question.is_answered?
          render_question_already_answered
        elsif question.destroy
          render json: question
        else
          render_question_errors(question)
        end
      end

      private

      def question_params
        params.require(:question).permit(:content, :question_type)
      end

      def find_question
        Question.find_by(id: params[:id], survey_id: params[:survey_id], user_id: @current_user.id)
      end

      def render_question_not_found
        render json: { error: 'Question not found' }, status: :not_found
      end

      def render_question_already_answered
        render json: { error: 'Question has already been answered and cannot be deleted' },
               status: :unprocessable_entity
      end

      def render_question_errors(question)
        render json: { error: question.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
