# frozen_string_literal: true

Devise.secret_key = SecureRandom.hex(50).inspect

Devise.setup do |config|
  # Required so users don't lose their carts when they need to confirm.
  # config.allow_unconfirmed_access_for = 1.days
  config.router_name = :spree
  # Add any other devise configurations here, as they will override the defaults provided by solidus_auth_devise.
end