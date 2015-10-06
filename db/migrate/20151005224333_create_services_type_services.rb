class CreateServicesTypeServices < ActiveRecord::Migration
  def change
  	remove_column :services, :type_service_id
    create_table :services_type_services do |t|
      t.references :service, index: true,  null: false
      t.references :type_service, index: true,  null: false
      t.timestamps
    end
  end
end
