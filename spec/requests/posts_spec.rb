require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  include ApplicationHelper
  include UsersHelper

  before(:context) do
    @user = create(:user)
  end

  after(:context) do
    @user.wall.destroy
    @user.destroy
  end

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
      sign_in @user
    end

    describe 'GET /posts/:id' do
      before(:example) do
        @post = @user.posts.create(attributes_for(:post,
                                                   wall_id: @user.wall.id))
        get post_path(@post)
      end

      it "displays a post's page" do
        expect(response).to have_http_status(:success)
        assert_select('.post-container', 1)
        assert_select('.post-container a', text: full_name(@post.author))
        assert_select('.post-container', text: /#{creation_time(@post)}/)
        assert_select('.post-container', text: /#{@post.body}/)
      end
    end
  end
end
