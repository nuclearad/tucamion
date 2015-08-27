class Admin::BrandsTruckController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Marcas de camion', :admin_brands_truck_index_path, :options => { :title =>'Inicio' }

  def index


    @brands = BrandTruck.all


  end


  def new



    @type = TypeTruck.find_by_id(params[:type_truck_id])
    @brand = BrandTruck.new
    add_breadcrumb 'Agregar'
  end

  def create

    @brand = BrandTruck.new(allowed_params)
    if @brand.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_brands_truck_index_path
    else
      render 'new'
    end


  end

  def edit

    @brand = BrandTruck.find(params[:id])
    add_breadcrumb 'Editar'
  end

  def update

    @brand = BrandTruck.find(params[:id])

    if @brand.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_brands_truck_index_path
    else
      render 'new'
    end


  end

  def destroy

    @brand = BrandTruck.find(params[:id])
    if @brand.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_brands_truck_index_path
    else
      render 'new'
    end


  end

  private
  def allowed_params
    params.require(:brand_truck).permit(:name)
  end
end
