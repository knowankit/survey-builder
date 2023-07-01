class HeartbeatController < ApplicationController
  def index
    render json: { status: 'success', message: 'Heartbeat API is running' }
  end
end
