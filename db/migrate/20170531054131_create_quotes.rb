class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :kind
      t.string :promo
      t.string :level
      t.decimal :price

      t.timestamps null: false
    end
  end
end
