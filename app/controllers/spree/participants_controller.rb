module Spree
  class ParticipantsController < Spree::StoreController
    
    def reserve
      Spree::Participant.create(
        user_id: params[:participants][:user_id],
        product_id: params[:participants][:product_id]
      )
      redirect_to product_path(Spree::Product.find(params[:participants][:product_id]))
    end
  end
end