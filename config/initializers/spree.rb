# Configure Solidus Preferences
# See http://docs.solidus.io/Spree/AppConfiguration.html for details

# Solidus version defaults for preferences that are not overridden
Spree.load_defaults '3.2.0'

Spree.config do |config|
  # Core:
  # Default currency for new sites
  config.currency = "EUR"
  config.address_requires_state = false
  config.admin_products_per_page = 50
  config.orders_per_page = 50
  config.default_country_iso = "DE"
  Spree::Money.default_formatting_rules[:format] = '%n %u'
  Spree::Money.default_formatting_rules[:sign_before_symbol] = false
  Spree::PermittedAttributes.user_attributes << :spree_role_ids
  config.address_requires_state = false

  # from address for transactional emails

  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false

  # When set, product caches are only invalidated when they fall below or rise
  # above the inventory_cache_threshold that is set. Default is to invalidate cache on
  # any inventory changes.
  # config.inventory_cache_threshold = 3

  # Configure adapter for attachments on products and taxons (use ActiveStorageAttachment or PaperclipAttachment)
  config.image_attachment_module = 'Spree::Image::ActiveStorageAttachment'
  config.taxon_attachment_module = 'Spree::Taxon::ActiveStorageAttachment'

  # Defaults
  # Permission Sets:

  # Uncomment and customize the following line to add custom permission sets
  # to a custom users role:
  # config.roles.assign_permissions :role_name, ['Spree::PermissionSets::CustomPermissionSet']

  # Admin:

  # Custom logo for the admin
  # config.admin_interface_logo = "logo/solidus.svg"

  # Gateway credentials can be configured statically here and referenced from
  # the admin. They can also be fully configured from the admin.
  #
  # Please note that you need to use the solidus_stripe gem to have
  # Stripe working: https://github.com/solidusio-contrib/solidus_stripe
  #
  # config.static_model_preferences.add(
  #   Spree::PaymentMethod::StripeCreditCard,
  #   'stripe_env_credentials',
  #   secret_key: ENV['STRIPE_SECRET_KEY'],
  #   publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  #   server: Rails.env.production? ? 'production' : 'test',
  #   test_mode: !Rails.env.production?
  # )
  config.roles.assign_permissions :schüler, ['Spree::PermissionSets::DefaultCustomer']
  config.roles.assign_permissions :vereinsmitglied, ['Spree::PermissionSets::DefaultCustomer']
  config.roles.assign_permissions :trainer, ['Spree::PermissionSets::Trainer']
end

Spree::Backend::Config.configure do |config|
  config.locale = 'de'

  # Uncomment and change the following configuration if you want to add
  # a new menu item:
  #
  # config.menu_items << config.class::MenuItem.new(
  #   [:section],
  #   'icon-name',
  #   url: 'https://solidus.io/'
  # )

  config.menu_items << config.class::MenuItem.new(
    [:TrainerCashList],
    "eur",
    condition: -> { can?(:admin, Spree::TrainerCashList) },
    label: "cash_list",
    url: "/admin/trainer_cash_lists"
  )
  config.menu_items << config.class::MenuItem.new(
    [:Menus],
    "bars",
    condition: -> { can?(:admin, Spree::Menu) },
    label: "menu",
    url: "/admin/menus"
  )

  # Custom frontend product path
  #
  # config.frontend_product_path = ->(template_context, product) {
  #   template_context.spree.product_path(product)
  # }
end

Spree::Api::Config.configure do |config|
  config.requires_authentication = true
end

Spree.user_class = "Spree::LegacyUser"

Rails.application.config.to_prepare do
  Spree::Product.allowed_ransackable_attributes |= ["date_and_time", "participants_count"]
  Spree::Product.allowed_ransackable_associations |= ["trainer"]
end

# Rules for avoiding to store the current path into session for redirects
# When at least one rule is matched, the request path will not be stored
# in session.
# You can add your custom rules by uncommenting this line and changing
# the class name:
#
# Spree::UserLastUrlStorer.rules << 'Spree::UserLastUrlStorer::Rules::AuthenticationRule'
