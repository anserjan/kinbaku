module Dojo
  class ParticipantSubscriber
    include Omnes::Subscriber

    handle :order_finalized, with: :create_participants_on_order_completed
    handle :reservation_confirmed, with: :send_reservation_confirmed_email

    def create_participants_on_order_completed(event)
      order = event.payload[:order]
      user = order.user
      order.products.each do |product|
        participant = product.participants.find_by(user_id: user.id)
        participant.order = order
        participant.update_state('up')
      #   # if order mit paypal bezahlt oder als Vereinsmitgliedpromotion setze payment_status
        validate_for_payment_status(order) ? participant.payment_status = true : nil
        participant.save
      end
    end

    def validate_for_payment_status order
      order.adjustments.each do |adjustment|
        return true if adjustment.eligible && adjustment.label.downcase.include?('verein')
      end
      order.payments.each do |payment| 
        if payment.state.eql?('completed') || payment.payment_method.name.downcase.include?('paypal')
         return true
        end
      end
      return false
    end

    def send_reservation_confirmed_email(event)
      participant = event.payload[:participant]
      ::Spree::Config.participant_mailer_class.confirm_reservation(participant.user, participant.product).deliver
    end

  end
end