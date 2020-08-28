require 'rails_helper'

RSpec.describe WelcomePageController, type: :controller do
  describe "GET #show" do

    context 'when not logged in' do
      it 'is expected to respond with success' do
        get :show
        expect(response).to have_http_status :success
      end
    end

    context 'when logged in' do
      let(:user) { create(:regular_user) }
      it 'is expected to respond with redirect' do
        sign_in user
        get :show
        expect(response).to have_http_status :redirect
      end
    end

  end
end
