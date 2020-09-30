require 'rails_helper'

RSpec.describe "Api::Auth::Registrations", type: :request do

  let(:user) { create(:user) }

  describe 'POST /sign_up' do
    it 'sign_upが成功すること' do
      user_params = { name: "sign_up_user", email: "sign_up_user@gmail.com", password: "password", password_confirmation: "password"}
      expect { post '/api/v1/auth', params: user_params }.to change(User, :count).by(+1)
      expect(response.status).to eq(200)
    end
    it 'sign_upが失敗すること' do
      user_params = { name: "sign_up_user", email: "sign_up_user@gmail.com", password: "", password_confirmation: ""}
      expect { post '/api/v1/auth', params: user_params }.to change(User, :count).by(+0)
      expect(response.status).to eq(422)
    end
  end

  describe 'POST /sign_in' do
    it 'sign_inが成功すること' do
      post "/api//v1/auth/sign_in", params: { email: user.email, password: user.password }
      expect(response.status).to eq(200)
    end
    it 'sign_inが失敗すること' do
      post "/api//v1/auth/sign_in", params: { email: "", password: "" }
      expect(response.status).to eq(401)
    end
  end

  describe 'DELETE /sign_out' do
    it 'sign_outが成功すること' do
      login_user = { email: user.email, password: user.password }
      auth_tokens = sign_in(login_user)
      delete "/api//v1/auth/sign_out", headers: auth_tokens
      expect(response.status).to eq(200)
    end
    it 'sign_outが失敗すること' do
      delete "/api//v1/auth/sign_out"
      expect(response.status).to eq(404)
    end
  end

end
