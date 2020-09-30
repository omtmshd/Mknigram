require 'rails_helper'

RSpec.describe 'Api::V1::Relationships', type: :request do

  let(:user) { create(:user) }
  let(:sub_user) { create(:sub_user) }

  describe 'POST /api/v1/relationships' do
    it 'ログインしている場合、成功すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      expect { post '/api/v1/relationships', params: { relationship: { followed_id: sub_user.id }}, headers: auth_tokens }.to change(Relationship, :count).by(+1)
      expect(response.status).to eq(201)
    end

    it 'ログインしていない場合、失敗すること' do
      post '/api/v1/relationships', params: { relationship: { followed_id: sub_user.id }}
      expect(response.status).to eq(401)
    end
  end

  describe 'DELETE /api/v1/relationships/:id' do
    it 'ログインしている場合、成功すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      user.follow(sub_user)
      expect { delete "/api/v1/relationships/#{sub_user.id}", headers: auth_tokens }.to change(Relationship, :count).by(-1)
      expect(response.status).to eq(200)
    end

    it 'ログインしていない場合、失敗すること' do
      user.follow(sub_user)
      delete "/api/v1/relationships/#{sub_user.id}"
      expect(response.status).to eq(401)
    end
  end
end
