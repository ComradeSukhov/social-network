require 'rails_helper'
include ApplicationHelper
include UsersHelper

RSpec.describe 'Posts', type: :request do
  context 'when not logged in' do
    describe 'all requests' do
      it 'respond with redirect' do
        responses = []

        get post_path(0)
        responses << response
        post posts_path
        responses << response

        responses.each do |response|
          expect(response).to have_http_status(:redirect)
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end

  context 'when logged in' do
    before(:context) do
      @user = create(:user)
    end

    after(:context) do
      @user.wall.destroy
      @user.destroy
    end

    before(:example) do
      sign_in @user
      @post_attributes = attributes_for(:post,
                                         author_id: @user.id,
                                           user_id: @user.id,
                                           wall_id: @user.wall.id)
    end

    after(:example) do
      @post.destroy if @post
    end

    describe 'GET /posts/:id' do
      it "displays a post's page" do
        @post_attributes.delete(:user_id)
        @post = Post.create(@post_attributes)

        get post_path(@post)

        expect(response).to have_http_status(200)
        assert_select('p', text: /#{@post.body}/)
      end
    end

    describe 'POST /posts' do
      before(:example) do
        get user_path(@user)
        expect(response).to have_http_status(200)
      end

      context 'when post have incorrect data' do
        it 'displays an error message' do
          @post_attributes.delete(:body)

          expect { post posts_path, params: { post: @post_attributes } }
            .not_to change { Post.count }
          expect(response).to have_http_status(302)
          expect(flash[:failed_post_errors]).to be_present

          follow_redirect!
          expect(response).to have_http_status(200)
          assert_select('.notification.is-danger')
        end
      end

      context 'when post have correct data' do
        it 'displays a page includeing new post' do
          expect { post posts_path, params: { post: @post_attributes } }
            .to change { Post.count }.by 1
          expect(response).to have_http_status(302)

          follow_redirect!
          expect(response).to have_http_status(200)
          assert_select('p', text: @post_attributes[:body])
        end
      end
    end
  end
end
