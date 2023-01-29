module Spree
  module Admin
    class ParticipantsController < Spree::Admin::ResourceController
      helper 'spree/admin/products'
      belongs_to 'spree/product', find_by: :slug

      def index
        @participants = @product.participants
      end
      
      def update
        participant = Spree::Participant.all.find(params[:id])
        participant.payment_status = !participant.payment_status
        participant.save
        redirect_to admin_product_participants_path(params[:product_id])
      end
    end
  end
end