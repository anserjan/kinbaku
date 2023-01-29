module Spree
  module Admin
    class DepositsController < Spree::Admin::ResourceController

      def destroy
        Spree::Deposit.find(params[:id].to_i).destroy
        return redirect_to deposits_admin_user_url(params[:user_id])
      end

    end
  end
end