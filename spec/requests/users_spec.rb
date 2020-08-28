require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /user/:id" do

    context 'when not logged in' do
      it "is expected to respond with redirect" do
        get user_path(rand(1..1000))
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      let(:user) { create(:regular_user) }
      it "is expected to respond with success" do
        sign_in user
        get user_path(rand(1..1000))
        expect(response).to have_http_status(:success)
      end
    end
  end
end
