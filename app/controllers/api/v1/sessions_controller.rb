class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:login]

  def login
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      auth_token = JsonWebToken.encode({uuid: user.uuid})
      user.update(last_login: Time.now)
      render json: { user: filter(user), auth_token: auth_token }, status: :ok
    else
      render json: { error: 'Usuario/contraseña no válidos' }, status: :unauthorized
    end
  end

  private
    def filter(user)
      user_tmp = user
      user = user_tmp.attributes.except('id', 'created_at', 'updated_at', 'password_digest')
      user["last_login"] = user_tmp.last_login.strftime("%d/%m/%Y %I:%M%p %z")
      user["vault_uuid"] = user_tmp.vault.uuid
      user
    end
end