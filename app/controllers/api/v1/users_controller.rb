class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request!, only: [:create]

  def create
    @user = User.new(user_params)
    if @user.save
      @user.create_vault(value: 0)
      create_initial_codes
      render json: filter(@user), status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: filter(@current_user), status: :ok
  end

  def update
    if @current_user.update_attributes(user_update_params)
      render json: filter(@current_user), status: :ok
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  private
    def create_initial_codes
      5.times do
        code = Code.create(value: rand(0.0...100.0).round(2), code_status_id: 11)
        @user.codes << code
      end
    end

    def user_params
      params.permit(:name,
        :last_name,
        :email,
        :username,
        :password,
        :password_confirmation,
        :city,
        :country,
        :phone,
        :document)
    end

    def user_update_params
      params.permit(:name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :city,
        :country,
        :phone,
        :document)
    end



    def filter(user)
      user_tmp = user
      user = user_tmp.attributes.except('id', 'created_at', 'updated_at', 'password_digest')
      user["last_login"] = user_tmp.last_login.strftime("%d/%m/%Y %I:%M%p %z") unless user["last_login"].nil?
      user["vault_uuid"] = user_tmp.vault.uuid
      user
    end
end