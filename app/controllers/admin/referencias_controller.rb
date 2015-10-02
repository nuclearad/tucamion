class Admin::ReferenciasController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Tipos', :admin_type_truck_referencias_path, :options => { :title =>'Inicio' }


  def index
    @referencias = Referencia.where(type_truck_id: params[:type_truck_id]).order(:name).all
    @search= @referencias.search(params[:q])
    @referencias_filter= @search.result.page(params[:page]).per(10)
    @truck = TypeTruck.find_by_id(params[:type_truck_id])
    add_breadcrumb @truck.name
  end

  def new

    @truck = TypeTruck.find_by_id(params[:type_truck_id])
    @referencia= Referencia.new(:type_truck_id => @truck)
    add_breadcrumb @referencia.name, :admin_type_truck_referencias_path, :options => { :title =>'Inicio' }
    add_breadcrumb 'Agregar Referencia'
  end


  def create
    @referencia = Referencia.new(allowed_params)
    @referencia.type_truck_id = params[:type_truck_id]
    if @referencia.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_type_truck_referencias_path
    else
      render 'new'
    end


  end

  def edit

    @referencia = Referencia.find(params[:id])
    @truck = TypeTruck.find_by_id(params[:type_truck_id])
    add_breadcrumb @truck.name, :admin_type_truck_referencias_path, :options => { :title =>'Inicio' }
    add_breadcrumb 'Editar'

  end

  def update
    @referencia = Referencia.find(params[:id])
    if @referencia.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_type_truck_referencias_path
    else
      render :edit
    end

  end

  private
  def allowed_params
    #params.require(:truck).permit(:nombre, :quintarueda)
    params.require(:referencia).permit!
  end


end
