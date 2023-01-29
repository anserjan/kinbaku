module Spree::Admin
  class TrainerCashListsController < Spree::Admin::ResourceController

    # get all users with trainer role
    # @trainers_collection: map trainers to array of [name,id]
    # @choosen_id: save last user choice for select box
    # @trainers: all trainers
    # @trainer: selected trainer

    def index
      trainers = Spree::User.trainers

      @trainers_collection = trainers.collect { |trainer| [trainer.bill_address.name, trainer.id] }.push(["All", 0])

      if (!(params[:trainer_id].present?) || (params[:trainer_id].to_i.eql? 0))
        @choosen_id = 0
        @trainers = trainers
      elsif params[:trainer_id]
        @choosen_id = params[:trainer_id]
        @trainer = trainers.find(params[:trainer_id].to_i)
      end

    end

  end
end