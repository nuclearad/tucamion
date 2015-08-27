class CreateSpacesTrucks < ActiveRecord::Migration
  def change
    create_table :spaces_trucks do |t|
      t.string :name

      t.timestamps
    end
  end
end
