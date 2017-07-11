class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.belongs_to :user, index: true
      t.string :street
      t.string :street2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :year_built
      t.boolean :alarm_system
      t.string :token
      t.string :status

      t.timestamps null: false
    end
  end
end
