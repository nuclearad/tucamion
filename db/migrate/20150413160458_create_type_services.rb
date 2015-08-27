class CreateTypeServices < ActiveRecord::Migration
  def change
    create_table :type_services do |t|
      t.string :name
      t.string :link_rewrite

      t.timestamps
    end
  end
end
