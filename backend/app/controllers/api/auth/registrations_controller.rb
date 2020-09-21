# frozen_string_literal: true

module Api
  module Auth
    # class Api::Auth::RegistrationsController < ApplicationController
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      private

      def sign_up_params
        params.permit(:name, :nickname, :email, :img, :password, :password_confirmation)
      end

      def account_upadte_params
        params.permit(:name, :nickname, :email, :img)
      end
    end
  end
end
