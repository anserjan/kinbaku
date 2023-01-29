module Dojo
  class ParticipantSubscriber
    include Omnes::Subscriber

    handle :order_finalized, with: :create_participants_on_order_completed

    def create_participants_on_order_completed(event)
      order = event.payload[:order]
      order.products.each do |product|
        unless participant_exits(order, product)
          # if order mit paypal bezahlt oder als Vereinsmitgliedpromotion setze payment_status
          if validate_for_payment_status(order)
            participant = ::Spree::Participant.create(product: product, order: order, email: get_email(order), payment_status: true)
          else
            participant = ::Spree::Participant.create(product: product, order: order, email: get_email(order))
          end
          participant.save
        end
      end
    end

    def participant_exits current_order, current_product
      if current_order.user.present?
        return current_product.participants.any? { |participant| participant.email.eql? current_order.user.email }
      end
    end

    def get_email order
      if order.user
        return order.user.email
      else
        return order.email
      end
    end

    def validate_for_payment_status order
      puts "validate_for_payment_status"
      order.adjustments.each do |adjustment|
        if adjustment.eligible && adjustment.label.downcase.include?("verein")
          return true
        end
      end
      order.payments.each do |payment| 
        if payment.state.eql?("completed") || payment.payment_method.name.downcase.include?("paypal")
         return true
        end
      end
      return false
    end

  end
end