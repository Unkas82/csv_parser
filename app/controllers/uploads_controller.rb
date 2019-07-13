  # UploadsController
  #
  #   For upload products and variants from .csv
  #
  class UploadsController < ApplicationController
    # GET : products
    #
    def products
      DataUploader.new(csv_string).upload_products

      redirect_to spree.root_path, status: :no_content
    end



    private

    def csv_string
      params[:file].read
    end

  end
