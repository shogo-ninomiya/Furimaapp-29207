class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like

  def create
    user = current_user
    item = Item.find(params[:item_id])
    like = Like.create(user_id: user.id, item_id: @item.id)
  end

  def destroy
    user = current_user
    item = Item.find(params[:item_id])
    like = Like.find_by(user_id: user.id, item_id: @item.id)
    like.delete
  end

  private
  def set_like
    @item = Item.find(params[:item_id])
  end
end
