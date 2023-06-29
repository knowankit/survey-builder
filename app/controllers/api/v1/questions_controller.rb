class Api::V1::QuestionsController < Api::V1::ApplicationController
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
    question = Question.find_by(id: params[:id] ,survey_id: params[:survey_id], user_id: @current_user.id)

    if question
      if question.is_answered?
        render json: { error: "Question has already been answered and cannot be deleted" }, status: :unprocessable_entity
      elsif question.destroy
        render json: question
      else
        render json: { error: question.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Question not found" }, status: :not_found
    end
  end

  private

  def question_params
    params.require(:question).permit(:content, :question_type)
  end
end
