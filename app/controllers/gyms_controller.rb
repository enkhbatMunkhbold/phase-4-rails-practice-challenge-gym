class GymsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    gyms = Gym.all
    render json: gyms
  end

  def show
    gym = get_gym
    if gym
      render json: gym
    else
      render_not_found_response
    end
  end

  def destroy
    gym = get_gym
    if gym
      gym.destroy
      head :no_content
    else
      render_not_found_response
    end
  end

  def update
    gym = get_gym
    if gym
      gym.update(gym_params)
      render json: gym
    else
      render_not_found_response
    end
  end

  private

  def get_gym
    Gym.find(params[:id])
  end

  def gym_params
    params.permit(:name, :address)
  end

  def render_not_found_response
    render json: { error: "Gym not found" }, status: :not_found
  end

end
