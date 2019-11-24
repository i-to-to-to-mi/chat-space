# require 'rails_helper'

# # メッセージ一覧ページを表示するアクション
# describe MessagesController do
#   # 複数のexampleで同一のインスタンスを使いたい場合
#   # letメソッドを使う
#   let(:group) { create(:group) }
#   let(:user) { create(:user) }
# #letメソッドの特徴 
# # 初回の呼び出し時のみ実行される
# # 複数回行われる処理を一度の処理で実装できるため、テストを高速にすることができる
# # 一度実行された後は常に同じ値が返って来る

#   describe '#index' do
# # ログインしている場合の記述
#     context 'log in' do
#       # beforeブロック内の処理は、各exampleが実行される直前に、毎回実行される
#       # ログインする、擬似的にindexアクションを動かすリクエスト
#       before do
#         login user
#         get :index, params: { group_id: group.id }
#       end

#       # インスタンス変数に代入されたオブジェクトは、コントローラのassigns メソッド経由で参照
#       # @messageを参照したい場合、assigns(:message)と記述
#       # be_a_new()←@messageはMessage.newで定義された新しい
#                   # Messageクラスのインスタンス
#       it 'assigns @message' do
#         expect(assigns(:message)).to be_a_new(Message)
#       end

#       it 'assigns @group' do
#         expect(assigns(:group)).to eq group
#       end

#       it 'redners index' do
#         expect(response).to render_template :index
#       end
#     end
# # ログインしていない場合の記述
#     context 'not log in' do
#       before do
#         get :index, params: { group_id: group.id }
#       end

#       it 'redirects to new_user_session_path' do
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#   end
# end

require 'rails_helper'

# メッセージ一覧ページを表示するアクション
describe MessagesController do
  # 複数のexampleで同一のインスタンスを使いたい場合
  # letメソッドを使う
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {
          post :create,
          params: params
        }

        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'does not count up' do
          expect{ subject }.not_to change(Message, :count)
        end

        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'not log in' do

      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end