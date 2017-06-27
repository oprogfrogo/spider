class CreateAutos < ActiveRecord::Migration
  def change
    create_table :autos do |t|
      t.belongs_to :user, index: true
      t.string :vin
      t.integer :year
      t.string :make
      t.string :model
      t.string :status

      t.timestamps null: false
    end
  end
end
