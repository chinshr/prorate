class Investment < ApplicationRecord
  belongs_to :investor
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
end 
