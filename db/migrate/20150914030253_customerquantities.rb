class Customerquantities < ActiveRecord::Migration
  def change
  	create_table :quantities do |t|
      t.references :customer, index: true,  null: false
      t.integer :total_trucks, default: 0 
      t.integer :total_extras, default: 0
      t.integer :total_services, default: 0
      t.integer :current_trucks, default: 0
      t.integer :current_extras, default: 0
      t.integer :current_services, default: 0
      t.timestamps
    end
  end
end
