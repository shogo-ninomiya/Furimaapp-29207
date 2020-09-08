class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  def checked
    
  end



  private
  def item_params
    params.require(:item).permit(:name, :comment, :price, :category_id, :status_id, :delivery_id, :area_id, :day_id, :image).merge(user_id: current_user.id)
  end
end
