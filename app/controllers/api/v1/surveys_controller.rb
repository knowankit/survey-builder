class Api::V1::SurveysController < ApplicationController
  def index
    @surveys = Survey.all

    render json: @surveys
  end

  def create
    @survey = Survey.create(name: params[:name], permalink: params[:permalink])

    render json: @survey
  end

  def update
    @survey = Survey.find(params[:id])
    @survey = Survey.update(name: params[:name], permalink: params[:permalink])

    render json: @survey
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy

    render json: "#{@survey.id} is deleted"
  end
end
