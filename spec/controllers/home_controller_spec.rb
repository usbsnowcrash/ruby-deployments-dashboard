require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context 'authenticated' do
    before do
      @request.session[:token] = 'example_token'
    end
    describe 'GET #index' do
      it 'fetches the list of teams' do
        get :index
        expect(WebMock).to have_requested(:get, 'https://api.github.com/user/teams?access_token=example_token')
          .to_return(status: 200, body: '', headers: {})
        expect(response).to render_template(:index)
      end
    end
  end

  context 'unauthenticated' do
    describe 'GET #index' do
      it 'shows the default view' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
end
