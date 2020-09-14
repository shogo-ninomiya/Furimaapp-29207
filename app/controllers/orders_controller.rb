class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_index, except: [:index]
  # before_actionにて二番の質問の回答


  def index 
    @item = Item.find(params[:item_id])
  end

  def create
    #form_objをつかって保存する動きをとる
  end


  private

  def move_to_index
    unless user_signed_in?
      redirect_to action: :root_path
    end
  end
end
