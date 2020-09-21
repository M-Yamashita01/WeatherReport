# frozen_string_literal: true

# class ApplicationController < ActionController::Base
class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery except: %i[create update]

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # 新規登録時(sign_up時)にnameというキーのパラメータを追加で許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
