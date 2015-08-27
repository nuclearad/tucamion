class AddFieldToTruck < ActiveRecord::Migration
  def change

    add_attachment :trucks, :picture1
    add_attachment :trucks, :picture2
    add_attachment :trucks, :picture3
    add_attachment :trucks, :picture4
    add_attachment :trucks, :picture5
    add_column :trucks, :descripccion, :text

  end
end
