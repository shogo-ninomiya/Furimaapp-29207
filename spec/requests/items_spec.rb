require 'rails_helper'
RSpec.describe "Items", type: :request do

  before do
    image = fixture_file_upload('public/images/test_image.png')
    @item = FactoryBot.create(:item, image: image)
  end

  describe "GET /items" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get root_path
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストするとレスポンスに出品済みのアイテムの名前が存在する" do 
      get root_path
      expect(response.body).to include @item.name
    end
    it "indexアクションにリクエストするとレスポンスに出品済みのアイテムの値段が存在する" do 
      get root_path
      expect(response.body).to include @item.price.to_s
      # 金額はintegerで登録しているが、ビュー上では二千円と文字列で出力されているためto_sにてstring形でテスト
    end
    it "indexアクションにリクエストするとレスポンスに出品済みのアイテムの画像URLが存在する" do
      get root_path
      expect(response.body).to include @item.image.filename.to_s
      # 画像はアクティブストレージにfilenameというカラム名で保存されているため
    end
    it "indexアクションにリクエストするとレスポンスに検索フォームが存在する" do 
      get root_path
      expect(response.body).to include "キーワードから探す"
    end
  end

  describe "GET /show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get item_path(@item)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストするとレスポンスに出品済みのアイテムの名前が存在する" do 
      get item_path(@item)
      expect(response.body).to include @item.name
    end
    it "showアクションにリクエストするとレスポンスに出品済みのアイテムの値段が存在する" do 
      get item_path(@item)
      expect(response.body).to include @item.price.to_s
    end
    it "showアクションにリクエストするとレスポンスに出品済みのアイテムの画像URLが存在する" do 
      get item_path(@item)
      expect(response.body).to include @item.image.filename.to_s
    end
    it "showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する" do 
      get item_path(@item)
      expect(response.body).to include "＜コメント一覧＞"
    end
  end 

  describe "GET /new" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get new_item_path(@item)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストするとレスポンスに画像投稿フォームが存在する" do 
      get new_item_path(@item)
      expect(response.body).to include "クリックしてファイルをアップロード"
    end
    it "showアクションにリクエストするとレスポンスにアイテムの名前入力フォームが存在する" do 
      get new_item_path(@item)
      expect(response.body).to include "商品名"
    end
    it "showアクションにリクエストするとレスポンスにアイテムの説明入力フォームが存在する" do 
      get new_item_path(@item)
      expect(response.body).to include "商品の説明"
    end
    it "showアクションにリクエストするとレスポンスにアイテムの詳細洗濯フォームが存在する" do 
      get new_item_path(@item)
      expect(response.body).to include "商品の詳細"
    end
  end 

  describe "GET /edit" do
    it "editアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get new_item_path(@item)
      expect(response.status).to eq 200
    end
    it "editアクションにリクエストするとレスポンスに画像投稿フォームが存在する" do 
      get new_item_path(@item)
      expect(response.body).to include "クリックしてファイルをアップロード"
    end
    it "editアクションにリクエストするとレスポンスにアイテムの名前入力フォームが存在する" do 
      get new_item_path(@item)
      expect(response.body).to include "商品名"
    end
    it "editアクションにリクエストするとレスポンスにアイテムの説明入力フォームが存在する" do 
      get new_item_path(@item)
      expect(response.body).to include "商品の説明"
    end
    it "editアクションにリクエストするとレスポンスにアイテムの詳細洗濯フォームが存在する" do 
      get new_item_path(@item)
      expect(response.body).to include "商品の詳細"
    end
  end 
end
