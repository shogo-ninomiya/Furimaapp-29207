require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: @user.id)
    @item.image = fixture_file_upload('public/images/test_image.png')
    @item.save
    @comment = FactoryBot.build(:comment, item_id: @item.id, user_id: @user.id)
    # @comments = FactoryBot.build(:comment,comment_id:@comment.id)

  end

  describe 'コメント新規投稿' do
    context 'コメント新規投稿がうまくいくとき' do
      it 'Textの項目が存在すれば登録できる' do
        expect(@comment).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'Textが空だと登録できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
    end
  end
end
