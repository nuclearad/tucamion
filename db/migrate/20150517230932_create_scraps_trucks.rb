class CreateScrapsTrucks < ActiveRecord::Migration
  def change
    create_table :scraps_trucks do |t|
      t.string :name

      t.timestamps
    end
  end
end
