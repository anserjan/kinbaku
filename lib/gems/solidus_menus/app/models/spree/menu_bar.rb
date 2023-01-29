class Spree::MenuBar < ActiveRecord::Base

  has_many :menus

  validates_presence_of :name

end
