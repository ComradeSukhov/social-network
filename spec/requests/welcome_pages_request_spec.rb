require 'rails_helper'

RSpec.describe "/welcome_page", type: :request do
  describe "GET /show" do
    context 'when not logged in' do
      it "it responds with success" do
        get welcome_page_path
        expect(response).to have_http_status :success
      end
    end

    context 'when logged in' do
      let(:user) { create(:regular_user) }

      it "it responds with redirect" do
        sign_in user
        get welcome_page_path
        expect(response).to have_http_status :redirect
      end
    end
  end
end
