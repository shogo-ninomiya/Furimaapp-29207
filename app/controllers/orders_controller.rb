class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  # ↑ログインされていなければ、ログイン画面に遷移する
  before_action :move_to_index, only: [:index]
  # ↑ログインされていなければ、トップページに遷移する
  before_action :buy_out, only: [:index]


  # user_signed_in? && current_user.id == @item.user_id


  def index 
    @item = Item.find(params[:item_id])
    @order = Order.new
  end

  def create
    #form_objをつかって保存する動きをとる
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      return redirect_to root_path
    else
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
      amount: order_params[:price],
      card: order_params[:token],
      currency:'jpy'
    )
  end
end
