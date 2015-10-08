class AddAireAcondicionadoToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :aireAcondicionado, :boolean, default: false
  end
end
