require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do

      buyer = FactoryBot.create(:user)
      seller = FactoryBot.create(:user)
      item = FactoryBot.build(:item , user_id: seller.id)
      item.image = fixture_file_upload('public/images/test_image.png')
      @order_address = FactoryBot.build(:order_address, item_id: item.id ,user_id: buyer.id)
    end

    context '購入がうまくいくとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
    end

    
    context '購入がうまくいかないとき' do
      it 'post_codeが空だと保存できないこと' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeにハイフンがないと保存できないこと' do
        @order_address.post_code = '1111111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'post_codeにハイフンと7桁入力がないと保存できないこと' do
        @order_address.post_code = '111111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'prefecture_idが1だと保存できないこと' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'blockが空だと保存できないこと' do
        @order_address.block = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block can't be blank")
      end
      it 'tellphoneが空だと保存できないこと' do
        @order_address.tellphone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tellphone can't be blank")
      end
      it 'tellphoneが10桁か11桁以外だと保存できないこと' do
        @order_address.tellphone = '000000000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tellphone is invalid")
      end
      it 'tellphoneにハイフンがあると保存できないこと' do
        @order_address.tellphone = '090-0000-0000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tellphone is invalid")
      end
      it 'tokenが空だと保存できないこと' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end