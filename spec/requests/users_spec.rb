require 'rails_helper'

RSpec.describe "/users", type: :request do
  before(:context) do
    @user = create(:user)
  end

  after(:context) do
    @user.wall.destroy
    @user.destroy
  end

  describe "GET #show" do
    context 'when not logged in' do
      before(:example) do
        get user_path(rand(1..1000))
      end

      it "it responds with redirect" do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      before(:example) do
        sign_in @user
        get user_path(@user)
      end

      it "displays a user's page" do
        expect(response).to have_http_status(:success)
        assert_select('#userFullName', @user.first_name + ' ' + @user.last_name)
        assert_select('form[action = ?]', posts_path)
      end
    end
  end

  describe "GET #index" do
    context 'when not logged in' do
      before(:example) do
        get users_path
      end

      it "it responds with redirect" do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      before(:example) do
        sign_in @user
      end

      context 'when there is no other users registered' do
        before(:example) do
          get users_path
        end

        it "renders empty page" do
          expect(response).to have_http_status(:success)
          assert_select('#usersList') do
            assert_select('li', 0)
          end
        end
      end

      context 'when there is some other users registered' do
        before(:example) do
          @users_amount = rand(3..150)
          create_list(:user, @users_amount)
          get users_path
        end

        it "renders a page with #{ @users_amount } users" do
          expect(response).to have_http_status(:success)
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
