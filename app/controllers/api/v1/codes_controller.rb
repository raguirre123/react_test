class Api::V1::CodesController < ApplicationController
  def user
    @codes = @current_user.codes
    render json: @codes.map {|code| filter(code)}
  end

  def buy
    if @current_user.vault.value >= params[:value].to_f
      code = Code.create(value: rand * (0.2 * params[:value].to_f) + 0.9 * params[:value].to_f, code_status_id: 11)
      @current_user.vault.update(value: @current_user.vault.value - params[:value].to_f)
      @current_user.codes << code
      render json: filter(code), status: :ok
    else
      render json: { error: "Not enough money to buy" }, status: :bad_request
    end
  end

  private
    def filter(code)
      code_tmp = code
      code = code_tmp.attributes.except('id', 'created_at', 'updated_at', 'user_id')
      code['code_status_id'] = code_tmp.code_status.name
      code
    end
end