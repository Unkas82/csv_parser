  # UploadsController
  #
  #   For upload products and variants from .csv
  #
  class UploadsController < ApplicationController
    # GET : products
    #
    def products
# binding.pry
      # DataUploader.new(csv_string).upload_products

      DataUploader.new(csv_path).upload_products

      redirect_to spree.root_path, status: :no_content
    end



    private

    def csv_path
      params[:file].tempfile.path
    end

  end
