class CreateOffercustomers < ActiveRecord::Migration
  def change
    create_table :offercustomers do |t|
      t.belongs_to :customer
      t.belongs_to :offer
      t.timestamps
    end
  end
end
