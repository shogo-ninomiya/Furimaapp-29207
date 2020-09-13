class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_index, except: [:index]


  def index 
    @item = Item.find(params[:item_id])
  end

  

  private

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
