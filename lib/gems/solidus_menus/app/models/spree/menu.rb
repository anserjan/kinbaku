class Spree::Menu < ActiveRecord::Base

  belongs_to :menu_bar

  alias_attribute :position, :sequence

  validates_presence_of :link_text
  validates_presence_of :url
  validates_presence_of :menu_bar

  default_scope { order(:sequence) }

end
