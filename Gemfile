source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3", ">= 7.0.3.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.7.2'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.4.2"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "capistrano", "~> 3.17", require: false
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem "capistrano3-nginx"
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "solidus_auth_devise"

gem "solidus_core", "~> 3.4.0"
gem "solidus_backend", "~> 3.4.0"
gem "solidus_api", "~> 3.4.0"
gem "canonical-rails"
gem "solidus_support"
gem "truncate_html"
gem "view_component", "~> 3.10.0"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "apparition", "~> 0.6.0", github: "twalpole/apparition"
  gem "rails-controller-testing", "~> 1.0.5"
  gem "rspec-activemodel-mocks", "~> 1.1.0"
  gem "solidus_dev_support", "~> 2.5"
end

gem 'ckeditor', github: 'galetahub/ckeditor'
gem "ruby-vips"
gem 'solidus_paypal_commerce_platform', github: 'solidusio/solidus_paypal_commerce_platform', branch: 'v1.0.3'
gem 'solidus_static_content', github: 'solidusio-contrib/solidus_static_content'
gem 'solidus_content_blocks', path: 'lib/gems/solidus_content_blocks'
gem 'jquery-rails'
gem 'solidus_i18n'