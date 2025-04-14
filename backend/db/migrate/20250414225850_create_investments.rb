class CreateInvestments < ActiveRecord::Migration[8.0]
  def change
    create_table :investments do |t|
      t.decimal :amount
      t.references :investor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
