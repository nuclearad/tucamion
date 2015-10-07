class CreateExtrasBrandsExtras < ActiveRecord::Migration
  def change
  	remove_column :extras, :brand_extra_id
    create_table :extras_brands_extras do |t|
      t.references :extra, index: true,  null: false
      t.references :brand_extra, index: true,  null: false
      t.timestamps
    end
  end
end
