# frozen_string_literal: true
# == Schema Information
#
# Table name: spree_products
#
class SpreeProduct < ApplicationRecord

  validates :name, presence: true
end
