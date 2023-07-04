class Api::V1::SurveysController < Api::V1::ApplicationController
  before_action :authenticate_user

  def index
    surveys = Survey.where(user_id: @current_user.id)
    render json: surveys
  end

  def show
    survey = Survey.find_by(id: params[:id], user_id: @current_user.id)

    if survey
      render json: survey
    else
      render json: { error: 'Survey not found' }, status: :not_found
    end
  end

  def create
    survey = Survey.new(survey_params)
    survey.user_id = @current_user.id

    if survey.save
      render json: survey
    else
      render json: { errors: survey.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    survey = Survey.find_by(id: params[:id], user_id: @current_user.id)

    if survey
      if survey.update(name: params[:name], permalink: params[:permalink])
        render json: survey
      else
        render json: { error: survey.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Survey not found' }, status: :not_found
    end
  end

  def destroy
    survey = Survey.find_by(id: params[:id], user_id: @current_user.id)

    if survey
      if survey.destroy
        render json: survey
      else
        render json: { error: survey.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Survey not found' }, status: :not_found
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:name, :permalink, :is_published)
  end
end
