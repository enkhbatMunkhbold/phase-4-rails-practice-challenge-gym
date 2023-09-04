class MembershipsController < ApplicationController
  
  # def index
  #   memberships = Membership.all
  #   render json: memberships
  # end
  
  def create
    new_membership = Membership.create(membership_params)
    if new_membership.valid?
      render json: new_membership, status: :created
    else
      render json: { error: "Membership already created" }
    end
  end

  # def destroy
  #   membership = Membership.find(params[:id])
  #   if membership
  #     membership.destroy
  #     head :no_content
  #   else
  #     render json: { error: "Membership not found" }, status: :not_found
  #   end
  # end

  private

  def membership_params
    params.permit(:charge, :gym_id, :client_id)
  end
end
