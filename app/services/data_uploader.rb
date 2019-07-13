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
    get_pure_data.each do |raw|
      fields = raw.join(';').split(';')

      unless already_exists?(fields[1])
        SpreeProduct.create(attributes(fields))
      end
    end
  end

  private

  def get_pure_data
    array = CSV.parse(@file)
    array.delete_at(0)

    remove_empty_rows(array)
  end

  def remove_empty_rows(array)
    array.delete([[";;;;;;;"]])
    array.delete([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    array
  end

  def attributes(fields)
    {
      name:         fields[1],
      description:  fields[2],
      available_on: fields[5].to_date,
      slug:         fields[6]
    }
  rescue ArgumentError

  end

  def already_exists?(name)
    SpreeProduct.find_by(name: name).present?
  end
end
