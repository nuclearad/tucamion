class Addpicturetobanner < ActiveRecord::Migration
  def change
    add_attachment :banners, :picture
  end
end
