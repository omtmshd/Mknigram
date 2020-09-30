require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:user) { create(:user) }

  describe 'GET /users' do
    it 'res code 200' do
      create_list(:n_user, 15)
      get '/api/v1/users?data_id=0'
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json.count).to eq(9)
    end
  end

  describe 'GET /users/:id' do
    it 'res code 200' do
      get "/api/v1/users/#{user.id}"
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH /users/:id' do
    it 'ログインユーザーと同じ場合、成功すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      valid_params = { name: 'name_edit', email: 'edit@gmail.com'}
      patch "/api/v1/users/#{user.id}", params: { user: valid_params }, headers: auth_tokens
      expect(response.status).to eq(200)
    end
    it 'ログインユーザーと異なる場合、失敗すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      sub_user = create(:sub_user)
      valid_params = { name: 'name_edit', email: 'edit@gmail.com'}
      patch "/api/v1/users/#{sub_user.id}", params: { user: valid_params }, headers: auth_tokens
      expect(response.status).to eq(422)
    end
    it 'ログインしていない場合、失敗すること' do
      valid_params = { name: 'name_edit', email: 'edit@gmail.com'}
      patch "/api/v1/users/#{user.id}", params: { user: valid_params }
      expect(response.status).to eq(401)
    end
  end

  describe 'PATCH /users/current' do
    it 'ログインしている場合、成功すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      get '/api/v1/users/current', headers: auth_tokens
      expect(response.status).to eq(200)
    end
    it 'ログインしていない場合、失敗すること' do
      get '/api/v1/users/current'
      expect(response.body).to eq("null")
    end
  end
end
