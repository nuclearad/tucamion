class CreateTransmissionsTrucks < ActiveRecord::Migration
  def change
    create_table :transmissions_trucks do |t|
      t.string :name

      t.timestamps
    end
  end
end
