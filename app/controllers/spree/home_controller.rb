# frozen_string_literal: true

module Spree
  class HomeController < Spree::StoreController
    helper 'spree/products'
    respond_to :html

    def index
      if Spree::Page.find_by(slug: "/verein").present?
        redirect_to "/verein"
      else
        redirect_to products_url
      end
    end
  end
end
