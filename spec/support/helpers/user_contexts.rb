shared_context 'create a user' do
  before(:context) do
    @user = create(:user)
  end

  after(:context) do
    @user.wall.destroy
    @user.destroy
  end
end
