class Spree::Menu < ActiveRecord::Base
  belongs_to :parent, class_name: "Spree::Menu", optional: true
  has_many :children, class_name: "Spree::Menu", foreign_key: "parent_id", dependent: :destroy
  belongs_to :page, class_name: "Spree::Page", optional: true
  belongs_to :content_block, class_name: "Spree::ContentBlock", optional: true

  validates_presence_of :link_text

  default_scope { order(:position) }
  scope :only_parents, -> { where("parent_id IS NULL") }

  def is_allowed_to_display_child_menus? page
    # sammel relevante url
    urls = self.children.map { |child| child.url }
    urls << self.url
    urls << self.parent.url if self.parent
    return true if urls.any? { |url| url.eql? page.link }
    return false
  end

  def link
    if self.page.present?
      return self.page.slug
    elsif self.url.present?
      return self.url
    elsif self.content_block
      return "#" + self.content_block.block_name
    else
      return ""
    end
  end
end