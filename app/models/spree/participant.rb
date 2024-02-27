module Spree
  class Participant < Spree::Base

    belongs_to :product, class_name: 'Spree::Product', inverse_of: :participants, counter_cache: true
    belongs_to :order, class_name: 'Spree::Order', optional: true
    belongs_to :user, class_name: 'Spree::User', inverse_of: :participants

    def payment
      if self.order.present?
        if self.order.adjustment_total.to_i != 0
          return 'Promotion'
        end
        self.order.payments.all.each do |payment|
          unless payment.state.eql? 'invalid'
            return payment.payment_method.name
          end
        end
        return 'unknown'
      end
    end

    def amount_paid product
      line_item = self.order.line_items.find { |li| Spree::Variant.find(li.variant_id).product.eql? product }
      return line_item.price if line_item
      return 0
    end

  end
end