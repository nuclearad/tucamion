class CreateBrandExtras < ActiveRecord::Migration
  def change
    create_table :brand_extras do |t|
      t.string :name
      t.string :link_rewrite

      t.timestamps
    end
  end
end
