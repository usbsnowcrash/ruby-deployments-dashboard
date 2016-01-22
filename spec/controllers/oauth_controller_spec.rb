require 'rails_helper'

RSpec.describe OauthController, type: :controller do
  describe 'GET #authorize' do
    it 'returns http success' do
      get :authorize
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #token' do
    it 'returns http success' do
      get :token, code: 'example_code'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #destroy' do
    it 'returns http success' do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end
end
