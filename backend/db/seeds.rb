# Create sample investors
investor_a = Investor.create!(name: "Investor A")
investor_b = Investor.create!(name: "Investor B")

# Create sample investments
investor_a.investments.create!(amount: 100.00)
investor_a.investments.create!(amount: 100.00)
investor_b.investments.create!(amount: 25.00)
investor_b.investments.create!(amount: 25.00) 
