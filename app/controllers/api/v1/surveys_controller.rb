class Api::V1::SurveysController < ApplicationController
  def index
    surveys = Survey.all

    render json: surveys
  end

  def create
    survey = Survey.new(survey_params)

    if survey.save
      render json: survey
    else
      render json: { errors: survey.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    survey = Survey.find(params[:id])
    render json: survey
  end

  def update
    survey = Survey.find(params[:id])
    survey = Survey.update(name: params[:name], permalink: params[:permalink])

    render json: survey
  end

  def destroy
    survey = Survey.find(params[:id])
    survey.destroy

    render json: "#{survey.id} is deleted"
  end

  private

  def survey_params
    params.require(:survey).permit(:name, :permalink, :is_published, :user_id)
  end
end
