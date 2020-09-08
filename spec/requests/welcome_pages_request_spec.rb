require 'rails_helper'

RSpec.describe 'WelcomePages', type: :request do
  before(:context) do
    @user = create(:user)
  end

  after(:context) do
    @user.wall.destroy
    @user.destroy
  end

  describe 'GET /welcome_page' do
    context 'when not logged in' do
      before(:example) do
        get welcome_page_path
      end

      it 'displays no aside block' do
        expect(response).to have_http_status :success
        assert_select('aside', false)
      end
    end

    context 'when logged in' do
      before(:example) do
        sign_in @user
        get welcome_page_path
      end

      it 'it responds with redirect' do
        expect(response).to have_http_status :redirect
      end
    end
  end
end
