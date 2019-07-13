  # UploadsController
  #
  #   For upload products and variants from .csv
  #
  class UploadsController < ApplicationController
    # GET : products
    #
    def products
# binding.pry
      DataUploader.new(params[:file].read).upload_products

      redirect_to spree.root_path
      # render json: root_json, status: :ok
    end

  end
