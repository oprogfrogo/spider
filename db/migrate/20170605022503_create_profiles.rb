class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :street
      t.string :street2
      t.string :city
      t.string :state
      t.string :postal_code
      t.date :dob
      t.string :dl_number
      t.string :martial_status

      t.timestamps null: false
    end
  end
end
