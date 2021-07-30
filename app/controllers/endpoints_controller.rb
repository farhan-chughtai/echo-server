class EndpointsController < ApplicationController
  before_action :set_endpoint, only: [:show, :update, :destroy]

  def index
    @endpoints = Endpoint.all
    render json: @endpoints
  end

  def show
    render json: @endpoint
  end

  def create
    @endpoint = Endpoint.new(endpoint_params[:attributes])
    if @endpoint.save
      render json: @endpoint, status: :created, location: @endpoint
    else
      respond_with_errors(@endpoint)
    end
  end

  def update
    if @endpoint.update(endpoint_params[:attributes])
      render json: @endpoint, location: @endpoint
    else
      respond_with_errors(@endpoint)
    end
  end

  def destroy
    @endpoint.destroy
  end

  private
    def set_endpoint
      @endpoint = Endpoint.find(params[:id])
    end

    def endpoint_params
      params.require(:data).permit(:type, attributes: [:verb, :path, response: [:code, :body, headers: {}]])
    end
end
