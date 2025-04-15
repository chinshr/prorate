class Api::InvestorsController < ApplicationController
  def index
    investors = if params[:query].present?
      Investor.where("name LIKE ?", "%#{params[:query]}%")
    else
      Investor.all
    end.map do |investor|
      {
        name: investor.name,
        average_investment_amount: investor.average_investment_amount
      }
    end
    
    render json: investors
  end
  
  def show
    investor = Investor.find_by!(name: params[:id].titleize)
    render json: {
      name: investor.name,
      average_investment_amount: investor.average_investment_amount
    }
    # render json: investor
  end
end 
