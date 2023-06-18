class Api::V1::QuestionsController < Api::V1::ApplicationController
  before_action :authenticate_user

  def index
    puts "all questions"
    questions = Question.find_by(survey_id: params[:survey_id], user_id: @current_user.id)

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

  private

  def question_params
    params.require(:question).permit(:content, :question_type)
  end
end
