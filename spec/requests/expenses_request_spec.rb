require 'spec_helper'

def login(user)
  OmniAuth.config.mock_auth[:identity] = OmniAuth::AuthHash.new({ provider: 'identity', uid: user.id })
  post '/auth/identity/callback', screen_name: user.screen_name, password: 'password1'
end

describe 'Expenses' do
  let!(:user) { create(:user) }

  before { login(user) }

  describe 'GET /expenses' do
    let!(:expenses) { create_list(:expense, 3, user: user) }

    context 'html' do
      let(:path) { '/expenses' }

      before { get path }

      it '支出一覧画面を表示する' do
        expect(response).to be_success
      end
    end

    context 'json' do
      let(:path) { '/expenses.json' }

      before { xhr :get, path}

      it '支出一覧を取得する' do
        expected_amounts = expenses.map(&:amount)
        actual_amounts = json.map { |e| e['amount'] }

        expect(actual_amounts).to match_array(expected_amounts)
      end
    end
  end

  describe 'GET /expenses/:id' do
    let!(:expense) { create(:expense, user: user) }
    let(:path) { "/expenses/#{expense.id}" }

    before { xhr :get, path }

    it '支出情報を取得する' do
      actual_expense = json['expense']

      expect(actual_expense['id']    ).to eq(expense.id)
      expect(actual_expense['amount']).to eq(expense.amount)
      expect(actual_expense['url']   ).to eq(expense_url(expense))
    end
  end

  describe 'POST /expenses' do
    let(:path) { '/expenses' }

    before { post path, params }

    context 'パラメータが正しいとき' do
      let(:params) { { expense: attributes_for(:expense, amount: 300) } }

      it '作成に成功し、showにリダイレクトする' do
        created_expense = Expense.last
        expect(created_expense.amount).to eq(params[:expense][:amount])
        expect(response).to redirect_to(action: :show, id: created_expense.id)
      end
    end

    context 'パラメータの支出金額がnilのとき' do
      let(:params) { { expense: attributes_for(:expense, amount: nil) } }

      it 'エラー情報を含んだjsonを取得する' do
        expect(json['errors']).to eq(["Amount can't be blank"])
      end
    end
  end

  describe 'PUT /expenses/:id' do
    let!(:expense) { create(:expense, user: user) }
    let(:path) { "/expenses/#{expense.id}" }

    before { put path, params }

    context 'パラメータが正しいとき' do
      let(:params) { { expense: attributes_for(:expense, amount: 300) } }

      it '更新に成功し、showにリダイレクトする' do
        updated_expense = Expense.find(expense.id)
        expect(updated_expense.amount).to eq(params[:expense][:amount])
        expect(response).to redirect_to(action: :show, id: expense.id)
      end
    end

    context 'パラメータの支出金額がnilのとき' do
      let(:params) { { expense: attributes_for(:expense, amount: nil) } }

      it 'エラー情報を含んだjsonを取得する' do
        expect(json['errors']).to eq(["Amount can't be blank"])
      end
    end
  end

  describe 'DELETE /expenses/:id' do
    let!(:expense) { create(:expense, user: user) }
    let(:path) { "/expenses/#{expense.id}" }

    before { delete path }

    it '支出情報の削除に成功する' do
      expect(response.status).to eq(204)
      expect { Expense.find(expense.id) }.to raise_error
    end
  end
end
