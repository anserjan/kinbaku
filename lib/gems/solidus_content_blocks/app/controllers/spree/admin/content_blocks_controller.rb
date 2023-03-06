class Spree::Admin::ContentBlocksController < Spree::Admin::ResourceController

  before_action :load_data
  create.before :init_position

  def index
    @content_blocks = Spree::ContentBlock.where(page_id: @page.id)
  end

  def update_positions
    if params[:positions]
      params[:positions].each do |id, index|
        Spree::ContentBlock.find_by(id: id, page: @page)
                           .update_attribute(:position, ((index.to_i+1)*10))
      end
    end
    respond_to do |format|
      format.js { render text: 'Ok' }
    end
  end

  def clone
    cloned = @content_block.create_clone
    redirect_to admin_page_content_blocks_url(@page)
  end

  def update
    
  end

  private

  def location_after_save
    edit_admin_page_content_block_url(@page, @content_block)
  end

  def load_data
    @page = Spree::Page.find(params[:page_id])
  end

  def init_position
    highest = Spree::ContentBlock.maximum(:position)
    @content_block.position = (highest.present?) ? (highest + 10) : 10
  end

end
