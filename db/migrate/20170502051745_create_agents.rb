class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :login
      t.string :password
      t.string :name
      t.string :email
      t.string :phone
      t.string :ext
      t.boolean :is_manager
      t.boolean :round_robin, :null => false

      t.timestamps null: false
    end
  end
end
