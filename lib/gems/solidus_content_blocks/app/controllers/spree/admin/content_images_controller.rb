class Spree::Admin::ContentImagesController < Spree::Admin::ResourceController

  before_action :load_data
  before_action :init_position, only: :create

  create.before :set_viewable
  update.before :set_viewable
  destroy.before :destroy_before

  def update_positions
    if params[:positions]
      params[:positions].each do |id, index|
        Spree::ContentImage.find_by(id: id).update_attribute(:position, ((index.to_i+1)*10))
      end
    end
    redirect_to location_after_save
  end


  private

  def location_after_save
    edit_admin_page_content_block_url(@page, @content_block)
  end

  def load_data
    @page = Spree::Page.find(params[:page_id])
    @content_block = Spree::ContentBlock.find(params[:content_block_id])
  end

  def set_viewable
    @content_image.viewable = @content_block
  end

  def destroy_before
    @viewable = @content_image.viewable
  end

  def init_position
    highest = Spree::ContentImage.maximum(:position)
    @content_image.position = (highest.present?) ? (highest + 10) : 10
  end

end
