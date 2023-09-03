class MembershipsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_uprocessable_entity_response

  def create
    memberships = Membership.all
    new_membership = Membership.create(membership_params)
    render json: new_membership, status: :created
  end

  def render_uprocessable_entity_response
    render json: { errors: exception.record.errors.full_messages }, status: :uprocessable_entity
  end

  def membership_params
    params.permit(:charge, :gym_id, :client_id)
  end
end
