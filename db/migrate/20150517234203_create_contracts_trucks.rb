class CreateContractsTrucks < ActiveRecord::Migration
  def change
    create_table :contracts_trucks do |t|
      t.string :name

      t.timestamps
    end
  end
end
