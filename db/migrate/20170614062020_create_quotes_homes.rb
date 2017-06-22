class CreateQuotesHomes < ActiveRecord::Migration
  def change
    create_table :quotes_homes do |t|
      t.references :home, index: true, foreign_key: true
      t.string :dwelling
      t.string :personal_property
      t.string :loss_of_use
      t.string :liability
      t.string :medical_payments
      t.string :deductible
      t.string :premises_alarm_fire_system
      t.string :contents_other_residents
      t.string :unscheduled_personal_property
      t.string :jewels_watches_furs
      t.string :money
      t.string :securities
      t.string :silver_gold_pewter
      t.string :firearms
      t.string :electronic_app_vehicles
      t.string :electronic_app_business
      t.string :workers_compensation
      t.string :inflation_guard
      t.string :ordinance_or_law_converage
      t.string :replace_cost_contents
      t.string :fungi_mold_bacteria
      t.string :total_premium

      t.timestamps null: false
    end
  end
end
