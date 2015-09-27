class Admin::TypeTruckController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Tipo', :admin_type_truck_index_path, :options => { :title =>'Inicio' }
  def index
    @types = TypeTruck.all
    @search = @types.search(params[:q])
    @types_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @type = TypeTruck.new
    add_breadcrumb 'Agregar'
  end

  def create

    @type = TypeTruck.new(allowed_params)
    if @type.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_type_truck_index_path
    else
      render 'new'
    end


  end

  def edit
    @type = TypeTruck.find(params[:id])
    add_breadcrumb 'Editar'
  end

  def update

    @type = TypeTruck.find(params[:id])

    if @type.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_type_truck_index_path
    else
      render 'new'
    end


  end

  def destroy

    begin
      @type = TypeTruck.find(params[:id])
      if @type.destroy
        flash[:notice] = 'Información eliminada correctamente'
        redirect_to admin_type_truck_index_path and return
      else
        render 'new'
      end
    rescue Exception => e
      flash[:notice] = 'El Tipo de camion no existe'
      redirect_to admin_type_truck_index_path and return
    end
  end




  private
  def allowed_params
    params.require(:type_truck).permit(:name)
  end
end
