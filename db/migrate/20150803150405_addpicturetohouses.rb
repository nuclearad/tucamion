class Addpicturetohouses < ActiveRecord::Migration
  def change

    add_attachment :houses, :picture

  end
end
