class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :customer, index: true, null: false
      t.references :offer, index: true, null: false
      t.string     :reference_code, index: true, null: false
      t.string     :signature
      t.float      :amount, null: false
      t.string     :gateway_status, defaulr: ''
      t.integer    :internal_status, default: 0 #no procesada
      t.string     :description
      t.timestamps
    end
  end
end
