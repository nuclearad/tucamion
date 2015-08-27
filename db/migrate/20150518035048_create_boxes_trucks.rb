class CreateBoxesTrucks < ActiveRecord::Migration
  def change
    create_table :boxes_trucks do |t|
      t.string :name

      t.timestamps
    end
  end
end
