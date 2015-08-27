class AddFieldPictureToService < ActiveRecord::Migration
  def change

    add_attachment :services, :picture1
    add_attachment :services, :picture2
    add_attachment :services, :picture3
    add_attachment :services, :picture4
    add_attachment :services, :picture5


  end
end
