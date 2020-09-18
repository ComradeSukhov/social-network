require 'rails_helper'
require_relative '../support/helpers/user_contexts'

RSpec.describe 'Posts', type: :request do
  include_context 'create a user'

  describe 'GET /posts/:id' do
    context 'when not logged in' do
      it 'responds with redirect' do
        get post_path(0)

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      before(:example) do
        sign_in @user
        @post_attributes = attributes_for(:post,
                                           author_id: @user.id,
                                             user_id: @user.id,
                                             wall_id: @user.wall.id)
      end

      it "displays a post's page" do
        @post_attributes.delete(:user_id)
        @post = Post.create(@post_attributes)

        get post_path(@post)

        expect(response).to have_http_status(200)
        assert_select('p', text: /#{@post.body}/)
      end
    end
  end

  describe 'POST /posts' do
    context 'when not logged in' do
      it 'responds with redirect' do
        post posts_path

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      before(:example) do
        sign_in @user
        @post_attributes = attributes_for(:post,
                                           author_id: @user.id,
                                             user_id: @user.id,
                                             wall_id: @user.wall.id)
      end

      context "when post's form contains incorrect data" do
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

      context "when post's form contains correct data" do
        it "creates a new post on user's wall" do
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
