module Spree
  module Admin
    class MenusController < Spree::Admin::ResourceController
      
      after_action :parameterize, only: [:create, :update]

      def update_positions
        if params[:positions]
          params[:positions].each do |id, index|
            Spree::Menu.find_by(id: id).update_attribute(:position, ((index.to_i+1)*10))
          end
        end
      end

      private

      def parameterize
        @menu.url = @menu.url.parameterize.prepend("/") if @menu.url.present?
        @menu.save
      end

    end
  end
end