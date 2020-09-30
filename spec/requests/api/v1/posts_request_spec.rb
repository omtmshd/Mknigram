require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do

  let(:user) { create(:user) }

  describe 'GET /posts' do
    it 'res code 200' do
      create_list(:post, 20, user_id: user.id)
      get '/api/v1/posts?data_id=0'
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json.count).to eq(15)
    end
  end

  describe 'GET /posts/:id' do
    it 'res code 200' do
      post = create(:post, user_id: user.id)
      get "/api/v1/posts/#{post.id}"
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /posts' do
    it 'ログインしている場合、成功すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      valid_params = { title: 'title', body: 'test_body', post_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.png')), user_id: user.id, category_ids: [] }
      expect { post '/api/v1/posts', params: { post: valid_params }, headers: auth_tokens }.to change(Post, :count).by(+1)
      expect(response.status).to eq(201)
    end
    it 'ログインしていない場合、失敗すること' do
      valid_params = { title: 'title', body: 'test_body', post_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.png')), user_id: user.id, category_ids: [] }
      expect { post '/api/v1/posts', params: { post: valid_params } }.to change(Post, :count).by(+0)
      expect(response.status).to eq(401)
    end
  end

  describe 'PATCH /posts/:id' do
    it 'ログインユーザーと投稿のユーザーが同じ場合、成功すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      post = create(:post, user_id: user.id)
      valid_params = { title: 'title_edit', body: 'test_body_edit', post_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.png')), user_id: user.id}
      patch "/api/v1/posts/#{post.id}", params: { post: valid_params }, headers: auth_tokens
      expect(response.status).to eq(200)
    end
    it 'ログインユーザーと投稿のユーザーが異なる場合、失敗すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      sub_user = create(:sub_user)
      post = create(:post, user_id: sub_user.id)
      valid_params = { title: 'title_edit', body: 'test_body_edit', post_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.png'))}
      patch "/api/v1/posts/#{post.id}", params: { post: valid_params }, headers: auth_tokens
      expect(response.status).to eq(422)
    end
    it 'ログインしていない場合、失敗すること' do
      post = create(:post, user_id: user.id)
      valid_params = { title: 'title', body: 'test_body', post_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.png'))}
      patch "/api/v1/posts/#{post.id}", params: { post: valid_params }
      expect(response.status).to eq(401)
    end
  end

  describe 'delete /posts/:id' do
    it 'ログインユーザーと投稿のユーザーが同じ場合、成功すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      post = create(:post, user_id: user.id)
      delete "/api/v1/posts/#{post.id}", headers: auth_tokens
      expect(response.status).to eq(200)
    end
    it 'ログインユーザーと投稿のユーザーが異なる場合、失敗すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      sub_user = create(:sub_user)
      post = create(:post, user_id: sub_user.id)
      delete "/api/v1/posts/#{post.id}", headers: auth_tokens
      expect(response.status).to eq(204)
    end
    it 'ログインしていない場合、失敗すること' do
      post = create(:post, user_id: user.id)
      delete "/api/v1/posts/#{post.id}"
      expect(response.status).to eq(401)
    end
  end
end
