require 'rails_helper'

RSpec.describe "WelcomePages", type: :request do
  describe "GET #show" do

    context 'when not logged in' do
      it 'is expected to respond with success' do
        get welcome_page_path
        expect(response).to have_http_status :success
      end
    end

    context 'when logged in' do
      let(:user) { create(:regular_user) }
      it 'is expected to respond with redirect' do
        sign_in user
        get welcome_page_path
        expect(response).to have_http_status :redirect
      end
    end

  end
end
