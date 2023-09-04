class MembershipsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_uprocessable_entity_response

  def index
    memberships = Membership.all
    render json: memberships
  end
  
  def create
    new_membership = Membership.create(membership_params)
    if new_membership.valid?
      render json: new_membership, status: :created
    else
      render json: { error: "Membership already created" }
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    if membership
      membership.destroy
      head :no_content
    else
      render json: { error: "Membership not found" }, status: :not_found
    end
  end

  def render_uprocessable_entity_response
    render json: { errors: exception.record.errors.full_messages }, status: :uprocessable_entity
  end

  def membership_params
    params.permit(:charge, :gym_id, :client_id)
  end
end
