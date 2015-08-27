class CreateBrandTrucks < ActiveRecord::Migration
  def change
    create_table :brand_trucks do |t|

      t.timestamps
    end
  end
end
