class Fieldstotrucks < ActiveRecord::Migration
  def change

    add_column :trucks, :pesobruto, :string
    add_column :trucks, :referecia_id, :integer
    add_column :trucks, :marcacapa, :string
    add_column :trucks, :tipotrailer, :string
    add_column :trucks, :marcatrailer, :string
    add_column :trucks, :modelotrailer, :string
    add_column :trucks, :numeroejestrailer, :string
    add_column :trucks, :sevendecontrailer, :string
    add_column :trucks, :direccion, :string
    add_column :trucks, :marcaequipohumedo_id, :integer
    add_column :trucks, :tipocarroceria_id, :integer
    add_column :trucks, :marcacarroceria_id, :integer
    add_column :trucks, :marcavolco_id, :integer
    add_column :trucks, :capacidadmetrica, :string
    add_column :trucks, :cuantosmetroscubicos, :string
    add_column :trucks, :Autocarpado, :string

  end
end
