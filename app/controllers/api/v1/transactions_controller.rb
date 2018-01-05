class Api::V1::TransactionsController < ApplicationController
  def save
    @vault = @current_user.vault
    code = Code.find_by(name: params[:code])
    code && code.code_status_id == 11 && code_belongs_to_current_user(code) ? redeem_code(code) : (render json: { error: "Invalid/Inactive code" }, status: :bad_request)
  end

  def transfer
    @vault = @current_user.vault
    if @vault
      if @vault.value >= params[:value].to_f
        other_vault = Vault.find_by(uuid: params[:other_uuid])
        if other_vault != @vault
          other_vault ? make_transfer(other_vault, params[:value].to_f) : (render json: { error: "Invalid other vault" }, status: :bad_request)
        else
          render json: { error: "You must enter another vault" }, status: :bad_request
        end
      else
        render json: { error: "Not enough money to transfer" }, status: :bad_request
      end
    else
      render json: { error: "Invalid vault" }, status: :bad_request
    end
  end

  private
    def redeem_code(code)
      actual_value = @vault.value
      @vault.update(value: (actual_value + code.value).round(2))
      code.update(code_status_id: 12)
      render json: filter_vault(@vault), status: :ok
    end

    def make_transfer(other_vault, value)
      other_vault_actual_value = other_vault.value
      other_vault.update(value: (other_vault_actual_value + value).round(2))
      @vault.update(value: (@vault.value - value).round(2))
      render json: { message: "Successful transfer", vault: filter_vault(@vault) }, status: :ok
    end

    def code_belongs_to_current_user(code)
      codes = @current_user.codes
      codes.include?(code) ? true : false
    end

    def filter_vault(vault)
      vault_tmp = vault
      vault = vault_tmp.attributes.except('id', 'created_at', 'updated_at', 'user_id')
      vault
    end
end