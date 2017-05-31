class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :street
      t.string :street2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :dob
      t.string :dl_number
      t.string :martial_status

      t.timestamps null: false
    end
  end
end
