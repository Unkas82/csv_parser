# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UploadsController, type: :request do
  let(:base_url) { '/uploads/products' }

  before(:each) do
    allow_any_instance_of(
      described_class
    ).to receive(
      :csv_path
    ).and_return(File.open(Rails.root.join('spec/support/files/sample.csv')))
  end

  it 'responds with 200 status' do
    post base_url

    expect(response.status).to eq(204)

    expect(SpreeProduct.count).to eq(3)

    expect(SpreeProduct.pluck(:name)).to match_array(["Ruby on Rails Bag", "Spree Bag", "Spree Tote"])
    expect(SpreeProduct.pluck(:description)).to match_array(
      ["Animi officia", "Rerum quaerat", "Consequuntur quibusdam"]
      )
    expect(SpreeProduct.pluck(:slug)).to match_array(["ruby-on-rails-bag", "spree-bag", "spree-tote"])
  end
end

