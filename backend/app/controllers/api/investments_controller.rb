class Api::InvestmentsController < ApplicationController
  def index
    investor = Investor.find_by!(name: params[:investor_id].titleize)
    render json: investor.investments
  end
end
