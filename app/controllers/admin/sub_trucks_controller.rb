class Admin::SubTrucksController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Tipos', :admin_type_truck_index_path, :options => { :title =>'Inicio' }


  def index
    @subs = SubTruck.where(type_truck_id: params[:type_truck_id]).order(:name).all
    @truck = TypeTruck.find_by_id(params[:type_truck_id])
  end

  def new


    @truck = TypeTruck.find_by_id(params[:type_truck_id])
    @sub = SubTruck.new(:type_truck_id => @truck)
    add_breadcrumb @sub.name, :admin_type_truck_sub_trucks_path, :options => { :title =>'Inicio' }





  end

  def create



    @sub = SubTruck.new(allowed_params)
    @sub.type_truck_id = params[:type_truck_id]
    if @sub.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_type_truck_sub_trucks_path
    else
      render 'new'
    end



  end

  def edit


    @sub = SubTruck.find(params[:id])
    @truck = TypeTruck.find_by_id(params[:type_truck_id])
    add_breadcrumb @truck.name, :admin_type_truck_sub_trucks_path, :options => { :title =>'Inicio' }
    add_breadcrumb 'Editar'


  end

  def update


    @sub = SubTruck.find(params[:id])
    if @sub.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_type_truck_sub_trucks_path
    else
      render 'new'
    end



  end

  def destroy
  end



  private
  def allowed_params
    #params.require(:truck).permit(:nombre, :quintarueda)
    params.require(:sub_truck).permit!
  end
end
