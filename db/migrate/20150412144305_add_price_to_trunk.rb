class AddPriceToTrunk < ActiveRecord::Migration
  def change
    add_column :trucks, :price, :float
  end
end
