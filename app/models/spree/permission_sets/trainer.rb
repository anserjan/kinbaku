module Spree
  module PermissionSets
    class Trainer < Spree::PermissionSets::Base
      def activate!
        can [:read, :admin], Spree::TrainerCashList
        can [:read, :admin, :addresses, :deposits], Spree::User
        can [:read, :admin, :destroy], Spree::Deposit
        can [:read, :admin], Spree::Product, trainer: user
        can [:manage], Spree::Participant
      end
    end
  end
end