class CreateQuotesAuto < ActiveRecord::Migration
  def change
    create_table :quotes_autos do |t|
      t.references :auto, index: true, foreign_key: true
      t.string :category
      t.string :carrier
      t.string :bodily_injury_liability
      t.string :property_damage_liability
      t.string :medical_payments
      t.string :uninsured_motorist_bodily_injury
      t.string :comprehensive
      t.string :collision
      t.string :waiver_of_collision_deductible
      t.string :rental_reimbursement
      t.string :roadside_coverage
      t.string :total_premium

      t.timestamps null: false
    end
  end
end
