class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :name
      t.integer :type_truck_id
      t.date :limite
      t.string :url

      t.timestamps
    end
  end
end
