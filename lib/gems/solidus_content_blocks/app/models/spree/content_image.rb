class Spree::ContentImage < Spree::Asset

  has_attached_file :attachment,
                    styles: {
                      mini: '120x120>', normal: '500x500>', normal_teaser: '500x650>', 
                      double: '1200x800>', full: '1600x1200>'
                    },
                    default_style: :mini,
                    url: '/spree/content_blocks/:id/:style/:basename.:extension',
                    path: ':rails_root/public/spree/content_blocks/:id/:style/:basename.:extension',
                    convert_options: { all: '-quality 95 -strip' }
  validates_attachment :attachment,
    presence: true,
    content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif) }

  # save the w,h of the original image (from which others can be calculated)
  # we need to look at the write-queue for images which have not been saved yet
  after_post_process :find_dimensions, if: :valid?

  def find_dimensions
    temporary = attachment.queued_for_write[:original]
    filename = temporary.path unless temporary.nil?
    filename = attachment.path if filename.blank?
    geometry = Paperclip::Geometry.from_file(filename)
    self.attachment_width  = geometry.width
    self.attachment_height = geometry.height
  end

end
