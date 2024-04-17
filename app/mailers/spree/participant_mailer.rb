module Spree
  class ParticipantMailer < BaseMailer

    layout "mailer"

    def confirm_reservation(user, product)
      @store = Spree::Store.default
      @product_url = product_url(product)
      @product = product
        mail(
        to: user.email,
        from: from_address(@store),
        subject: "#{@store.name} #{I18n.t(:subject, scope: [:spree, :mailer, :confirmed_reservation], product: product.name )}",
      )
    end

  end
end