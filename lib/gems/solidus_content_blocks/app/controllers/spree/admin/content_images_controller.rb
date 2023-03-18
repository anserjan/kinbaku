class Spree::Admin::ContentImagesController < Spree::Admin::ResourceController

  before_action :init_position, only: :create

  def new
    @content_block = Spree::ContentBlock.find(params[:content_block_id])
    @content_image = Spree::ContentImage.new
  end

  def create
    ci = Spree::ContentImage.create!(content_image_params)
    ci.content_block_id = params[:content_block_id]
    ci.save!
    redirect_to edit_admin_page_content_block_url(params[:page_id], params[:content_block_id])
  end

  def update_positions
    if params[:positions]
      params[:positions].each do |id, index|
        Spree::ContentImage.find_by(id: id).update_attribute(:position, ((index.to_i+1)*10))
      end
    end
    respond_to do |format|
      format.js { render text: 'Ok' }
    end
  end
  
  private 

  def content_image_params
    params.require(:content_image).permit(:image, :alt)
  end

  def init_position
    highest = Spree::ContentImage.maximum(:position)
    @content_image.position = (highest.present?) ? (highest + 10) : 10
  end

end