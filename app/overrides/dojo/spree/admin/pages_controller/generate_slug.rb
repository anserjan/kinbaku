module Dojo
  module Spree
    module Admin
      module PagesController
        module GenerateSlug

          def create
            ::Spree::Page.create(
              title: params[:page][:title],
              slug: "/" + params[:page][:title].downcase.split(" ").join("-"),
              body: params[:page][:body],
              store_ids: ::Spree::Store.first.id
            )
            redirect_to admin_pages_path
          end

          ::Spree::Admin::PagesController.prepend self
        end
      end
    end
  end
end