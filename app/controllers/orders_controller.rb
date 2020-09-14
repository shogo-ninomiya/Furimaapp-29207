class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  # ↑ログインされていなければ、ログイン画面に遷移する
  before_action :move_to_index, only: [:index]
  # ↑ログインされていなければ、トップページに遷移する
  before_action :buy_out, only: [:index]


  # user_signed_in? && current_user.id == @item.user_id


  def index 
    @item = Item.find(params[:item_id])
  end

  def create
    #form_objをつかって保存する動きをとる
  end


  private

  def move_to_index
    @item = Item.find(params[:item_id])
    if user_signed_in? && current_user.id == @item.user_id
      redirect_to action: :root_path
    end
  end

  def buy_out
    @item = Item.find(params[:item_id])
    if @item.order
      redirect_to root_path
    end
  end
end
