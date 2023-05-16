module Dojo
  module Spree
    module Admin
      module PagesController
        module GenerateSlug

          def create
            @new_page = ::Spree::Page.create(
              title: params[:page][:title],
              slug: "/" + params[:page][:title].downcase.split(" ").join("-"),
              body: params[:page][:body],
              store_ids: ::Spree::Store.first.id
            )
            @new_page.menu_id = params[:page][:menu_id].to_i if params[:page][:menu_id].present?
            @new_page.save!
            redirect_to admin_pages_path
          end

          def update
            @page.update(
              title: params[:page][:title],
              slug: params[:page][:slug],
              body: params[:page][:body],
              menu_id: params[:page][:menu_id].to_i
            )
            redirect_to admin_pages_path
          end

          ::Spree::Admin::PagesController.prepend self
        end
      end
    end
  end
end