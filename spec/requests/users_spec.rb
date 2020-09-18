require 'rails_helper'
require_relative '../support/helpers/user_creation'

RSpec.describe 'Users', type: :request do
  include_context 'create a user'

  describe 'GET /users/:id' do
    context 'when not logged in' do
      it 'responds with redirect' do
        get user_path(0)

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      before(:example) do
        sign_in @user
      end

      it "displays a user's page" do
        get user_path(@user)

        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /users' do
    context 'when not logged in' do
      it 'responds with redirect' do
        get users_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      before(:example) do
        sign_in @user
      end

      context 'when there is no other users registered' do
        it "doesn't display any user" do
          get users_path

          expect(response).to have_http_status(200)
          assert_select('#usersList') do
            assert_select('li', 0)
          end
        end
      end

      context 'when there is some other users registered' do
        before(:example) do
          @users_amount = rand(3..150)
          create_list(:user, @users_amount)
        end

        it "displays links to #{@users_amount} users" do
          get users_path

          expect(response).to have_http_status(200)
          assert_select('#usersList') do
            assert_select('li', @users_amount).each do |li|
              assert_select(li, "a:match('href', ?)", %r{users/\d+})
            end
          end
        end
      end
    end
  end
end
