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
        participant.payment_status = !participant.payment_status
        participant.save
        redirect_to admin_product_participants_path(params[:product_id])
      end

      def toggle_confirm
        participant = Spree::Participant.find(params[:id])
        if participant.state.eql?('request')
          participant.update_state('up')
        else
          participant.update_state('down')
        end
        participant.save
        if participant.state.include? 'confirm'
          Spree::ParticipantMailer.new.send_confirmed_reservation(participant.user, participant.product)
          # todo flash E-Mail Nachricht
        end
        redirect_back fallback_location: admin_product_participants_path(params[:product_id])
      end
    end
  end
end