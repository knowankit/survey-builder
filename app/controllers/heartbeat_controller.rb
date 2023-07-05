# frozen_string_literal: true

# This class is for checking the API heartbeat
class HeartbeatController < ApplicationController
  def index
    render json: { status: 'success', message: 'Heartbeat API is running' }
  end
end
