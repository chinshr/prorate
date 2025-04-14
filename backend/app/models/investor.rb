class Investor < ApplicationRecord
  has_many :investments, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  
  def average_investment_amount
    investments.average(:amount).to_f.round(2)
  end
end 
