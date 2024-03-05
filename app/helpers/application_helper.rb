module ApplicationHelper

  def datetimepicker_field_value(date)
    unless date.blank?
      l(date, format: t('spree.datetime_picker.format', default: '%Y'))
    end
  end

end
