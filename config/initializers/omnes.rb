# frozen_string_literal: true

Rails.application.config.to_prepare do
  %i[reservation_confirmed].each { |event_name| Spree::Bus.register(event_name) }
  Dojo::ParticipantSubscriber.new.subscribe_to(Spree::Bus)
end