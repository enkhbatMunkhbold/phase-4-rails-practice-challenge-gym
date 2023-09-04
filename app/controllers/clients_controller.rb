class ClientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # rescue_from ActiveRecord::RecordInvalid, with: :render_uprocessable_entity_response

  def index
    clients = Client.all 
    render json: clients, include: :memberships
  end

  def show
    client = Client.find(params[:id])
    if client
      render json: client, include: :memberships
    else
      render_not_found_response
    end
  end

  # def create    
  #   clients = get_clients
  #   names = clients.map{ |c| c.name}
  #   byebug
    
    # if names.include?(params[:name])
    #   render json: { error: "Client already created" }, status: :uprocessable_entity
    # else
    #   new_client = Client.create(client_params)
    #   render json: new_client, status: :created
    # end
  # end

  def destroy
    client = Client.find(params[:id])
    if client
      client.destroy
      head :no_content
    else
      render_not_found_response
    end
  end

  private

  def client_params
    params.permit(:name, :age)
  end

  def render_not_found_response
    render json: { error: "Client not found" }, status: :not_found
  end

  # def render_uprocessable_entity_response
  #   render json: { errors: exception.record.errors.full_messages }, status: :uprocessable_entity
  # end
end
