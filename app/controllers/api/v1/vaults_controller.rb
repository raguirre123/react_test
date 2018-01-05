class Api::V1::VaultsController < ApplicationController
  def show
    render json: filter(@current_user.vault), status: :ok
  end

  def filter(vault)
    vault_tmp = vault
    vault = vault_tmp.attributes.except('id', 'created_at', 'updated_at', 'user_id')
    vault
  end
end