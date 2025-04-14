class CreateInvestors < ActiveRecord::Migration[8.0]
  def change
    create_table :investors do |t|
      t.string :name

      t.timestamps
    end
  end
end
