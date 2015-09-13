class AddTypeToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :typeoffer, :integer, default: 0
  end
end
