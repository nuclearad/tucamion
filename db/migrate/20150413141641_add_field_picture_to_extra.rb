class AddFieldPictureToExtra < ActiveRecord::Migration
  def change

    add_attachment :extras, :picture1
    add_attachment :extras, :picture2
    add_attachment :extras, :picture3
    add_attachment :extras, :picture4
    add_attachment :extras, :picture5
  end
end
