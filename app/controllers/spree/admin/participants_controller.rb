module Spree
  module Admin
    class ParticipantsController < Spree::Admin::ResourceController
      helper 'spree/admin/products'
      belongs_to 'spree/product', find_by: :slug

      def index
        @participants = @product.participants
      end
      
      def update
        participant = Spree::Participant.find(params[:id])
        if params[:participant].present?
          participant.description = params[:participant][:description]
        else
          participant.payment_status = !participant.payment_status
        end
        participant.save
        redirect_to admin_product_participants_path(params[:product_id])
      end

      def toggle_confirm
        participant = Spree::Participant.find(params[:id])
        participant.confirmed = !participant.confirmed
        participant.save
        redirect_back fallback_location: admin_product_participants_path(params[:product_id])
      end
    end
  end
end