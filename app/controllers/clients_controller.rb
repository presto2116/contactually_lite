class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
  end

  def import
    Client.import(params[:file])
    redirect_to root_url, notice: "Data CSV Successfully Impoted"
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    head :no_content
  end
  
  def remove_all
    Client.delete_all
    flash[:notice] = "You have removed all results!"
    redirect_to clients_path
  end


  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:first_name, :last_name, :email_address, :phone_number, :company_name)
    end
end

