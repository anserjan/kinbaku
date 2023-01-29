module PageContentBlocks
  extend ActiveSupport::Concern

  included do
    has_many :content_blocks, -> { order("position") },
             class_name: "Spree::ContentBlock",
             foreign_key: :page_id, :dependent => :destroy
  end

end
