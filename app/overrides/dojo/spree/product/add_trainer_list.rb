module Dojo
  module Spree
    module Product
      module AddTrainerList

        def trainer_list
          @trainer_list = ::Spree::User.trainers
          @trainers_collection = []
          @trainer_list.each do |trainer|
            if trainer.bill_address.present?
              if trainer.bill_address.name.present?
                @trainers_collection.push([trainer.bill_address.name, trainer.id])
              end
            else
              @trainers_collection.push([trainer.email, trainer.id])
            end
          end
          return @trainers_collection
        end

        ::Spree::Product.prepend self
      end
    end
  end
end