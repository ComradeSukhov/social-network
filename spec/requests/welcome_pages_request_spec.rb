require 'rails_helper'
require_relative '../support/helpers/user_contexts'

RSpec.describe 'WelcomePages', type: :request do
  include_context 'create a user'

  describe 'GET /welcome_page' do
    context 'when not logged in' do
      it 'displays the welcome page' do
        get welcome_page_path

        expect(response).to have_http_status :success
      end
    end

    context 'when logged in' do
      it 'it responds with redirect' do
        sign_in @user
        get welcome_page_path

        expect(response).to have_http_status :redirect
      end
    end
  end
end
