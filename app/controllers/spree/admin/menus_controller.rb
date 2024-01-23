module Spree
  module Admin
    class MenusController < Spree::Admin::ResourceController
      
      def update_positions
        if params[:positions]
          params[:positions].each do |id, index|
            Spree::Menu.find_by(id: id).update_attribute(:position, ((index.to_i+1)*10))
          end
        end
      end

      def create
        @menu = Spree::Menu.create(
          link_text: params[:menu][:link_text],
          url: params[:menu][:url]
        )
        @menu.url.parameterize
        if params[:menu][:parent_id]
          @menu.parent_id = params[:menu][:parent_id]
          @menu.save
          return redirect_to admin_menu_url(params[:menu][:parent_id])
        end
        
        return redirect_to admin_menus_url
      end

      def update
        menu = Spree::Menu.find(params[:id])
        menu.link_text = params[:menu][:link_text]
        url = params[:menu][:url]
        menu.url = url.parameterize

        if params[:menu][:page].present?
          menu.page = Spree::Page.find(params[:menu][:page].to_i)
        else
          menu.page = nil
        end
        menu.save

        if params[:menu][:parent_id]
          return redirect_to admin_menu_url menu.parent_id
        end
        return redirect_to admin_menus_url
      end

    end
  end
end