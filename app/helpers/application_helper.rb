module ApplicationHelper

  def datetimepicker_field_value(date)
    unless date.blank?
      l(date, format: t('spree.datetime_picker.format', default: '%Y'))
    end
  end

  def user_bought_product_at current_product
    if spree_current_user.present?
      orders = spree_current_user.orders.select { |order| order.completed_at.present? }
      orders.each do |order|
        order.products.each do |product|
          if product.eql? current_product
            return I18n.t('spree.already_buyed_warning', date: order.completed_at.strftime("%d. %B %Y"))
          end
        end
      end
    end
    return ""
  end

end
