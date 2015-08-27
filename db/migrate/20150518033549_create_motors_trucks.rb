class CreateMotorsTrucks < ActiveRecord::Migration
  def change
    create_table :motors_trucks do |t|
      t.string :name

      t.timestamps
    end
  end
end
