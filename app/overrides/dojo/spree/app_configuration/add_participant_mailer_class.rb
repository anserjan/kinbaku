module Dojo
  module Spree
    module AppConfiguration
      module AddParticipantMailerClass

        def self.prepended(base)
          base.class_name_attribute :participant_mailer_class, default: 'Spree::ParticipantMailer'
        end

        ::Spree::AppConfiguration.prepend self
      end
    end
  end
end



