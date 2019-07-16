# frozen_string_literal: true

# DataUploader
#
#   For products uploading from .csv
#
class DataUploader
  require 'csv'

  attr_reader :text

  def initialize(file)
    @file = file
  end

  def upload_products
    items = []
    CSV.foreach(@file, headers: true) do |row|

      hash = row.to_h
      hash.reject! do |k,v|
        !%w[name description availability_date slug].include? k
      end
      hash["available_on"] = hash.delete "availability_date"

      next if is_not_date?(hash["available_on"])
      next if SpreeProduct.find_by(name: hash["name"]).present?
      items << hash
    end

    SpreeProduct.import(items) unless items.empty?
  end

  private

  def is_not_date?(string)
    (DateTime.parse(string) rescue nil).nil?
  end
end
