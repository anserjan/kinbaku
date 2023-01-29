module Dojo
  module Spree
    module Admin
      module UsersController
        module AddDepositsAction

          def deposits
            if request.post?
              deposit = @user.deposits.create(amount: params[:deposit][:amount], deposit_date: params[:deposit][:deposit_date], description: params[:deposit][:description])
              puts deposit.valid?
              unless deposit.valid?
                flash[:error] = I18n.t("spree.invalid_deposit")
              end
              redirect_to deposits_admin_user_url(params[:deposit][:user_id])
            end
            @deposit = ::Spree::Deposit.new
          end

          private

          ::Spree::Admin::UsersController.prepend self
        end
      end
    end
  end
end