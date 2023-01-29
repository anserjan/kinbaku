# frozen_string_literal: true

Rails.application.config.to_prepare do
    Dojo::ParticipantSubscriber.new.subscribe_to(Spree::Bus)
end