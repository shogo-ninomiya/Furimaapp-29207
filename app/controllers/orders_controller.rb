class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  # ↑ログインされていなければ、ログイン画面に遷移する
  before_action :move_to_index, only: [:index]
  # ↑ログインされていなければ、トップページに遷移する
  before_action :buy_out, only: [:index]



  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
    unless @item.present?
      redirect_to root_path
    end
  end



  def create
    #form_objをつかって保存する動きをとる
    @order_address = OrderAddress.new(order_address_params)
    @item = Item.find(params[:item_id])
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render 'index'
    end
  end


  private

  def order_params
    params.permit(:price, :token)
  end

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

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency:'jpy'
    )
  end

  def order_address_params
    params.permit(:item_id, :post_code, :prefecture_id, :city, :block, :building, :tellphone, :token).merge(user_id: current_user.id)
  end
end

