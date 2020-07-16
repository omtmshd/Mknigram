# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  #アカウント登録後のリダイレクト先
  def after_sign_up_path_for(resource)
    user_path(current_user.id)
  end

  #アカウント編集後のリダイレクト先
  def after_update_path_for(resource)
    user_path(current_user.id)
  end
end
