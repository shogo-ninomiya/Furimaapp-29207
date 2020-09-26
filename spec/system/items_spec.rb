require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item_name = "テスト商品名"
    @item_comment = "テスト商品紹介"
    @price = "3000"
  end
  
  context 'アイテム出品ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')
      # 投稿ページに移動する
      visit new_item_path
      # 商品画像をアップロードする
      image_path = Rails.root.join('spec/fixtures/public/images/test_image.png')
      attach_file('item[image]', image_path, make_visible: true)
      # 画像のプレビューが存在する
      expect(page).to have_selector("img[src$='png']")
      # フォームに情報を入力する
      fill_in 'item-name', with: @item_name
      fill_in 'item-info', with: @item_comment
      select "レディース", from: "item-category"
      select "未使用に近い", from: "item-sales-status"
      select "着払い(購入者負担)", from: "item-shipping-fee-status"
      select "北海道", from: "item-prefecture"
      select "1〜2日で発送", from: "item-scheduled-delivery"
      fill_in 'item-price', with: @price
      # 出品するとitemモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど出品した内容の商品が存在することを確認する（名前）
      expect(page).to have_content(@item_name)
      # トップページには先ほど出品した内容の商品が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='png']")
    end
  end

  context 'アイテム出品ができないとき'do
    it 'ログインしていないと新規出品ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがあることを確認しボタンを押す
      expect(page).to have_content('出品する')
      find(".purchase-btn-icon").click
      # ログインページへ遷移されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'アイテム編集', type: :system do
  before do
    image = fixture_file_upload('public/images/test_image.png')
    @item1 = FactoryBot.create(:item, image: image)
    @item2 = FactoryBot.create(:item, image: image)
  end
  context 'アイテム編集ができるとき' do
    it 'ログインしたユーザーは自分が出品したアイテムの編集ができる' do
      # アイテム1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 出品した商品の画像をクリックし、詳細ページへ遷移する
      find(:xpath, "//a[@href='/items/#{@item1.id}']").click
      # 画面に「商品の編集」ボタンがあることを確認し、ボタンを押すと編集ページへ遷移する
      find(:xpath, "//*[contains(concat(' ',@class,' '), ' item-red-btn ')]").click
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#item-name').value
      ).to eq @item1.name
      expect(
        find('#item-info').value
      ).to eq @item1.comment
      expect(
        find('#item-category').value
      ).to eq @item1.category_id.to_s
      expect(
        find('#item-sales-status').value
      ).to eq @item1.status_id.to_s
      expect(
        find('#item-shipping-fee-status').value
      ).to eq @item1.delivery_id.to_s
      expect(
        find('#item-prefecture').value
      ).to eq @item1.area_id.to_s
      expect(
        find('#item-scheduled-delivery').value
      ).to eq @item1.day_id.to_s
      expect(
        find('#item-price').value
      ).to eq @item1.price.to_s
      # 投稿内容を編集する
      fill_in 'item-name', with: "#{@item1.name}+テストname"
      fill_in 'item-info', with: "#{@item1.comment}+テストcomment"
      fill_in 'item-price', with: "4000000"
      # 編集してもItemモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)
      # アイテム詳細画面に遷移する
      expect(current_path).to eq item_path(@item1)
      # ページには先ほど変更した内容のアイテムが存在することを確認する（名前）
      expect(page).to have_content("#{@item1.name}+テストname")
      # ページには先ほど変更した内容のアイテムが存在することを確認する（コメント）
      expect(page).to have_content("#{@item1.comment}+テストcomment")
      # ページには先ほど変更した内容のアイテムが存在することを確認する（金額）
      expect(page).to have_content("4000000")
    end
  end

  context 'アイテム編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したアイテムの編集画面には遷移できない' do
      # アイテム1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # アイテム2の詳細ページへ遷移する
      find(:xpath, "//a[@href='/items/#{@item2.id}']").click
      # アイテム2の詳細ページには編集のボタンが表示されていないことを確認する
      expect(page).to have_no_content('商品の編集')
    end
    it 'ログインしていないとアイテムの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # アイテム1に「編集」ボタンがないことを確認する
      find(:xpath, "//a[@href='/items/#{@item1.id}']").click
      expect(page).to have_no_content('商品の編集')
      # トップページにいる
      visit root_path
      # アイテム2に「編集」ボタンがないことを確認する
      find(:xpath, "//a[@href='/items/#{@item2.id}']").click
      expect(page).to have_no_content('商品の編集')
    end
  end
end

RSpec.describe 'アイテム削除', type: :system do
  before do
    image = fixture_file_upload('public/images/test_image.png')
    @item1 = FactoryBot.create(:item, image: image)
    @item2 = FactoryBot.create(:item, image: image)
  end
  context 'アイテム削除ができるとき' do
    it 'ログインしたユーザーは自分が出品したアイテムの削除ができる' do
      # アイテム1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 出品した商品の画像をクリックし、詳細ページへ遷移する
      find(:xpath, "//a[@href='/items/#{@item1.id}']").click
      # 画面に「削除」ボタンがあることを確認し、ボタンを押すと削除が完了する。モデルのカウントも1減っていることを確認。
      expect{
      find_link('削除', href: item_path(@item1)).click
      }.to change { Item.count }.by(-1)
      # # トップページに遷移する
      expect(current_path).to eq root_path
      # # ページには先ほど変更した内容のアイテムが存在しないことを確認する（名前）
      expect(page).to have_no_content("#{@item1.name}")
      # # ページには先ほど変更した内容のアイテムが存在しないことを確認する（金額）
      expect(page).to have_no_content("#{@item1.comment}")
    end
  end

  context 'アイテム削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したアイテムには編集ボタンや削除ボタン遷移できない' do
      # アイテム1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @item1.user.email
      fill_in 'password', with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # アイテム2の詳細ページへ遷移する
      find(:xpath, "//a[@href='/items/#{@item2.id}']").click
      # アイテム2の詳細ページには削除のボタンが表示されていないことを確認する
      expect(page).to have_no_content('削除')
    end
    it 'ログインしていないとアイテムの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # アイテム1に「編集」ボタンがないことを確認する
      find(:xpath, "//a[@href='/items/#{@item1.id}']").click
      expect(page).to have_no_content('商品の編集')
      # トップページにいる
      visit root_path
      # アイテム2に「編集」ボタンがないことを確認する
      find(:xpath, "//a[@href='/items/#{@item2.id}']").click
      expect(page).to have_no_content('商品の編集')
    end
  end

  # 検索機能の結合テストやること
end



