class CreateQuotesHomes < ActiveRecord::Migration
  def change
    create_table :quotes_homes do |t|
      t.references :home, index: true, foreign_key: true
      t.string :dwelling_limit
      t.string :dwelling_premium
      t.string :personal_property_limit
      t.string :personal_property_premium
      t.string :loss_of_use_limit
      t.string :loss_of_use_premium
      t.string :liability_limit
      t.string :liability_premium
      t.string :medical_payments_limit
      t.string :medical_payments_premium
      t.string :deductible_limit
      t.string :deductible_premium
      t.string :premises_alarm_fire_system_limit
      t.string :premises_alarm_fire_system_premium
      t.string :contents_other_residents_limit
      t.string :contents_other_residents_premium
      t.string :unscheduled_personal_property_limit
      t.string :unscheduled_personal_property_premium
      t.string :jewels_watches_furs_limit
      t.string :jewels_watches_furs_premium
      t.string :money_limit
      t.string :money_premium
      t.string :securities_limit
      t.string :securities_premium
      t.string :silver_gold_pewter_limit
      t.string :silver_gold_pewter_premium
      t.string :firearms_limit
      t.string :firearms_premium
      t.string :electronic_app_vehicles_limit
      t.string :electronic_app_vehicles_premium
      t.string :electronic_app_business_limit
      t.string :electronic_app_business_premium
      t.string :workers_compensation_limit
      t.string :workers_compensation_premium
      t.string :inflation_guard_limit
      t.string :inflation_guard_premium
      t.string :ordinance_or_law_converage_limit
      t.string :ordinance_or_law_converage_premium
      t.string :replace_cost_contents_limit
      t.string :replace_cost_contents_premium
      t.string :fungi_mold_bacteria_limit
      t.string :fungi_mold_bacteria_premium
      t.string :total_premium_limit
      t.string :total_premium_premium
      t.integer :rating

      t.timestamps null: false
    end
  end
end
