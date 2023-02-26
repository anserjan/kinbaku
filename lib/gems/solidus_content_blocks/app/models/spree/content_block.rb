class Spree::ContentBlock < ActiveRecord::Base

  belongs_to :page, class_name: "Spree::Page"

  has_many_attached :images
  # , variants: {
  #   mini: { resize: "48x48" },
  #   small: { resize: "400x400" },
  #   product: { resize: "680x680" },
  #   large: { resize: "1200x1200" }
  # }

  validates_presence_of :content_type

  default_scope { order(:position) }

  def self.visible
    where(visible: true)
  end

  def self.available_content_types
    SolidusContentBlocks::Engine.config.content_block_types
  end

  def create_clone
    clone = self.dup
    others = Spree::ContentBlock.where(page: self.page)
    highest = others.max_by { |cb| cb.position }
    clone.position = highest.position + 10
    clone.block_name = self.block_name + " Kopie"
    clone.save!
	end

end
