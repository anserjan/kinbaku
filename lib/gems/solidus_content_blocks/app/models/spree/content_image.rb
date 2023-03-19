class Spree::ContentImage < Spree::Base

  has_one_attached :image do |attachable|
    attachable.variant :mini, resize_to_limit: [48, 48]
    attachable.variant :gallery, resize_to_limit: [300, 300]
    attachable.variant :small, resize_to_limit: [400, 400]
    attachable.variant :product, resize_to_limit: [680, 680]
    attachable.variant :large, resize_to_limit: [1200, 1200]
  end

end