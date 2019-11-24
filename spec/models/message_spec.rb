require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    context 'can save' do
      # contextでテストが条件毎にまとまって読みやすくなる
      #メッセージが保存される場合      
      it 'is valid with content' do
        expect(build(:message, image: nil)).to be_valid
        # buildメソッドはカラム名：値で引数を渡しファクトリーで定義されたデフォルトを上書きできる
      end

      # メッセージがなくても画像があれば保存できる
      it 'is valid with image' do
        expect(build(:message, content: nil)).to be_valid
      end

      # メッセージと画像があれば保存できる
      it 'is valid with content and image' do
        expect(build(:message)).to be_valid
      end
    end

    # 保存できない場合の群れ
    context 'can not save' do
      # メッセージも画像もない時、バリデーションによって保存されなくなっているか見る
      it 'is invalid without content and image' do
        message = build(:message, content: nil, image: nil)
        message.valid?
        # expectの引数に関して、message.errors[:カラム名]
        # そのカラムが原因のエラー文が入った配列を取り出す
        expect(message.errors[:content]).to include('を入力してください')
      end

      it 'is invalid without group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include('を入力してください')
      end

      it 'is invaid without user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include('を入力してください')
      end
    end
  end
end