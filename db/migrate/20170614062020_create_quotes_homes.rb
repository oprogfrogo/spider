class CreateQuotesHomes < ActiveRecord::Migration
  def change
    create_table :quotes_homes do |t|
      t.string :promo_date
      t.string :category
      t.string :carrier

      t.timestamps null: false
    end
  end
end
