module Spree
  class Deposit < Spree::Base

    belongs_to :user
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :deposit_date, presence: true

  end
end