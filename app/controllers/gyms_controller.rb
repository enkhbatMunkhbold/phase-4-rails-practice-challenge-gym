class GymsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    gyms = Gym.all
    render json: gyms
  end

  def show
    gym = Gym.find(params[:id])
    if gym
      render json: gym
    else
      render_not_found_response
    end
  end

  def destroy
    gym = Gym.find(params[:id])
    if gym
      gym.destroy
      head :no_content
    else
      render_not_found_response
    end
  end

  def render_not_found_response
    render json: { error: "Gym not found" }, status: :not_found
  end

end
