class CreateWheelsTrucks < ActiveRecord::Migration
  def change
    create_table :wheels_trucks do |t|
      t.string :name

      t.timestamps
    end
  end
end
