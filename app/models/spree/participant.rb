module Spree
  class Participant < Spree::Base

    belongs_to :product, class_name: 'Spree::Product', inverse_of: :participants, counter_cache: true
    belongs_to :order, class_name: 'Spree::Order', optional: true
    belongs_to :user, class_name: 'Spree::User', inverse_of: :participants
    
    # states:
    # request
    # confirm
    # complete

    def update_state direction
      if direction.include? 'up'
        if self.state.eql? 'request'
          self.state = 'confirm'
        elsif self.state.eql? 'confirm'
          self.state = 'complete'
        else
          self.state = 'request'
        end
      else
        if self.state.eql? 'complete'
          self.state = 'confirm'
        elsif self.state.eql? 'confirm'
          self.state = 'request'
        else
          self.state = 'request'
        end
      end
    end

    def state_message
      if self.state.eql? 'complete'
        return I18n.t('spree.course_purchased') if self.order.state.include?('complete')
        return I18n.t('spree.reserved_course')
      elsif self.state.eql? 'confirm'
        return I18n.t('spree.finish_payment')
      elsif self.state.eql? 'request'
        return I18n.t('spree.reservation_pending')
      end
    end
    
    def complete_state
      self.state = 'complete'
    end

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