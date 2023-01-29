module Dojo
  module Spree
    module User
      module AddCashListFunction

        def total_deposits
          deposits = ::Spree::Deposit.all.select { |deposit| deposit.user.eql? self }
          return 0 if deposits.empty?
          sum = 0.0
          deposits.each { |deposit| sum += deposit.amount }
          return sum
        end

        def cash_amount
          trainer_cash = 0.0
          ::Spree::Product.all.each do |product|
            if product.trainer.eql?(self) && product.participants.any?
              cash_payer_amount = 0
              product.participants.each do |participant|
                if participant.payment.eql?("Bar") && participant.payment_status
                  cash_payer_amount += 1
                end
              end
              trainer_cash += (product.price * cash_payer_amount)
            end
          end
          return trainer_cash
        end

        def cash_remaining
          self.cash_amount - self.total_deposits
        end
        

        ::Spree::User.prepend self
      end
    end
  end
end