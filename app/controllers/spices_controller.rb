class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_spice_not_found
  def index
    spices = Spice.all 
    render json: spices
  end

  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  def update
    spice = get_spice
    spice.update(spice_params)
    render json: spice
  end

  def destroy
    spice = get_spice
    spice.destroy
    head :no_content
  end

  private

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def get_spice
    spice = Spice.find(params[:id])
  end

  def render_spice_not_found
    render json: {error: "Spice not found."}, status: :not_found
  end
end
