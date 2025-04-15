class Api::ProrateController < ApplicationController
  def create
    allocation_amount = prorate_params[:allocation_amount].to_f
    investor_amounts = prorate_params[:investor_amounts]
    
    puts "*** Investor amounts: #{investor_amounts.inspect}"
    
    # Calculate total average amount for proration
    total_average = investor_amounts.sum { |i| i[:average_amount].to_f }
    
    # Calculate prorated amounts
    prorated_amounts = {}
    remaining_allocation = allocation_amount
    
    investor_amounts.each do |investor|
      name = investor[:name]
      requested_amount = investor[:requested_amount].to_f
      average_amount = investor[:average_amount].to_f
      
      # Calculate prorated amount
      prorated_amount = (allocation_amount * (average_amount / total_average)).round(2)
      
      # Ensure we don't exceed requested amount
      prorated_amount = [prorated_amount, requested_amount].min
      
      prorated_amounts[name] = prorated_amount
      remaining_allocation -= prorated_amount
    end
    
    # Distribute any remaining allocation
    if remaining_allocation > 0
      # Sort investors by their average amount in descending order
      sorted_investors = investor_amounts.sort_by { |i| -i[:average_amount].to_f }
      
      sorted_investors.each do |investor|
        name = investor[:name]
        requested_amount = investor[:requested_amount].to_f
        current_amount = prorated_amounts[name]
        
        # Calculate how much more we can add without exceeding requested amount
        available_space = requested_amount - current_amount
        
        if available_space > 0 && remaining_allocation > 0
          additional_amount = [available_space, remaining_allocation].min
          prorated_amounts[name] += additional_amount
          remaining_allocation -= additional_amount
        end
      end
    end
    
    render json: prorated_amounts
  end
  
  private
  
  def prorate_params
    params.permit(:allocation_amount, investor_amounts: [:name, :requested_amount, :average_amount])
  end
end 