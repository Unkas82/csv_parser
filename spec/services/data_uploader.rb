# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataUploader do
  describe 'upload products' do
    it 'uploads products properly' do
      file = File.open(Rails.root.join('spec/support/files/sample.csv')).read

      described_class.new(file).upload_products

      expect(SpreeProduct.count).to eq(3)

      expect(SpreeProduct.pluck(:name)).to match_array(["Ruby on Rails Bag", "Spree Bag", "Spree Tote"])
      expect(SpreeProduct.pluck(:description)).to match_array(
        ["Animi officia", "Rerum quaerat", "Consequuntur quibusdam"]
        )
      expect(SpreeProduct.pluck(:slug)).to match_array(["ruby-on-rails-bag", "spree-bag", "spree-tote"])
    end
  end
end