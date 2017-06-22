class QuotesAuto < ActiveRecord::Base
  belongs_to :auto

  validates_presence_of :category, :carrier, :bodily_injury_liability, :property_damage_liability, :medical_payments, :uninsured_motorist_bodily_injury, :comprehensive, :collision, :waiver_of_collision_deductible, :rental_reimbursement, :roadside_coverage, :total_premium
  validates_uniqueness_of :auto_id, scope: :category
end
