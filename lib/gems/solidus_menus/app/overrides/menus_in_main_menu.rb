Deface::Override.new(:virtual_path => "spree/admin/shared/_menu",
                     :name => "solidus_menus_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :disabled => false) do
                      <<-HTML
                        <% if can? :admin, Spree::MenuBar %>
                          <%= tab(:menu_bars, label: 'menu_bars', icon: 'align-justify') %>
                        <% end %>
                      HTML
                     end
