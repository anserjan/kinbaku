module Dojo
  module Spree
    module Taxon
      module AddContentBlocksAssociation
        
        def self.prepended(base)
          base.has_many :content_blocks, class_name: "Spree::ContentBlock", foreign_key: :taxon_id
        end

        ::Spree::Taxon.prepend self
      end
    end
  end
end