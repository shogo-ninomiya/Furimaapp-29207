require 'rails_helper'

RSpec.describe "購入機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    image = fixture_file_upload('public/images/test_image.png')
    @item1 = FactoryBot.create(:item, image: image)
  end

  context 'アイテム購入ができるとき' do
    it 'ログインしたユーザーは出品されているアイテムが購入できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 出品商品の画像をクリックし、詳細ページへ遷移する
      find(:xpath, "//a[@href='/items/#{@item1.id}']").click
      # 画面に「購入画面に進む」ボタンがあることを確認し、ボタンを押すと購入ページへ遷移する
      find(:xpath, "//*[contains(concat(' ',@class,' '), ' item-red-btn ')]").click
      # フォームに情報を入力し、購入ボタンを押す
      fill_in 'number', with: "4242424242424242"
      fill_in 'exp_month', with: "12"
      fill_in 'exp_year', with: "24"
      fill_in 'cvc', with: "123"
      fill_in 'postal-code', with: "123-1234"
      select "大阪府", from: "prefecture"
      fill_in 'city', with: "大阪市"
      fill_in 'addresses', with: "1-1-1"
      fill_in 'phone-number', with: "09090908080"
      # 購入するとOrderモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
        sleep(5)
        # 処理が早くてカウントを確認する前に処理してしまい、評価ができないためsleepをいれている
      }.to change { Order.count }.by(1)
      change { Address.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど購入した内容の商品が存在することを確認する（名前）
      expect(page).to have_content(@item_name)
      # トップページには先ほど購入した内容の商品が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='png']")
      # トップページには先ほど購入した内容の商品にSOLD-OUTが表示されていることを確認する（画像）
      expect(page).to have_content('Sold Out!!')
    end
  end

  context 'アイテム購入ができないとき'do
    it 'ログインしていないと新規出品ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 商品の画像をクリックし、詳細ページへ遷移する
      find(:xpath, "//a[@href='/items/#{@item1.id}']").click
      # アイテム1に「購入画面に進む」ボタンがあることを確認し、ボタンを押す
      expect(page).to have_content('購入画面に進む')
      find(:xpath, "//*[contains(concat(' ',@class,' '), ' item-red-btn ')]").click      # ログインページへ遷移されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end


  context 'アイテム購入ができないとき'do
    it 'フォームに必須項目が記入できないと新規出品ページに遷移できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 出品商品の画像をクリックし、詳細ページへ遷移する
      find(:xpath, "//a[@href='/items/#{@item1.id}']").click
      # 画面に「購入画面に進む」ボタンがあることを確認し、ボタンを押すと購入ページへ遷移する
      find(:xpath, "//*[contains(concat(' ',@class,' '), ' item-red-btn ')]").click
      # フォームに情報を入力し、購入ボタンを押す
      fill_in 'number', with: "4242424242424242"
      fill_in 'exp_month', with: "12"
      fill_in 'exp_year', with: ""
      fill_in 'cvc', with: ""
      fill_in 'postal-code', with: "123-1234"
      select "大阪府", from: "prefecture"
      fill_in 'city', with: ""
      fill_in 'addresses', with: "1-1-1"
      fill_in 'phone-number', with: "09090908080"
      find('input[name="commit"]').click
      # 購入できず、商品詳細画面に遷移する
      expect(current_path).to eq item_orders_path(@item1.id)
    end
  end
end

