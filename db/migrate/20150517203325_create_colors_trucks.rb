class CreateColorsTrucks < ActiveRecord::Migration
  def change
    create_table :colors_trucks do |t|
      t.string :name

      t.timestamps
    end

  end
end
