# frozen_string_literal: true

module Api
  module V1
    # This class handles API requests related to surveys
    class SurveysController < Api::V1::ApplicationController
      before_action :authenticate_user
      skip_before_action :authenticate_user, only: :show_published_survey

      def index
        default_per_page = 10
        default_page = 1
        per_page = params.fetch(:per_page, default_per_page).to_i
        page = params.fetch(:page, default_page).to_i

        surveys = Survey.where(user_id: @current_user.id).page(page).per(per_page)

        render json: { surveys:, page:, per_page: }
      end

      def show
        survey = Survey.friendly.includes(questions: :question_options).find(params[:id])

        if survey && survey.user_id == @current_user.id
          render json: survey, include: { questions: { include: :question_options } }
        else
          render json: { error: 'Survey not found' }, status: :not_found
        end
      end

      def publish
        survey = Survey.friendly.find(params[:survey_id])

        render json: { error: 'Survey not found' }, status: :unprocessable_entity if survey.user_id != @current_user.id

        if survey.update(is_published: true)
          render json: { message: 'Survey published successfully' }
        else
          render json: { error: 'Unable to publish survey' }, status: :unprocessable_entity
        end
      end

      def unpublish
        survey = Survey.friendly.find(params[:survey_id])

        if survey.update(is_published: false)
          render json: { message: 'Survey unpublished successfully' }
        else
          render json: { error: 'Unable to unpublish survey' }, status: :unprocessable_entity
        end
      end

      # This is API is public for getting the survey details
      def show_published_survey
        survey = Survey.friendly.includes(questions: :question_options).find(params[:survey_id])

        if survey && survey.is_published
          render json: survey, include: { questions: { include: :question_options } }
        else
          render json: { error: 'Survey not found' }, status: :not_found
        end
      end

      def permalink_validation
        survey = Survey.find_by(permalink: params[:permalink])

        if survey
          render json: { message: 'Permalink is not available', status: :conflict }
        else
          render json: { message: 'Permalink available' }
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
  end
end
