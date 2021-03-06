class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # , unless: :test?
  # skip_before_action :authenticate_user! ,if: :test?
  before_action :set_item, only: [:edit, :show, :destroy]
  # 購入ページに直接いけないように記述してやる

  def index
    @items = Item.all.order('created_at ASC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    @items = Item.search(params[:comment])
  end

  private

  def item_params
    params.require(:item).permit(:name, :comment, :price, :category_id, :status_id, :delivery_id, :area_id, :day_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  # def test?
  #   Rails.env.test?
  # end
end
