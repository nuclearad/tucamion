class CreateFieldMatriculaPlaca < ActiveRecord::Migration
  def change
      add_column :trucks, :placa_city_id, :integer
      add_column :trucks, :placa_state_id, :integer
    end
  end

