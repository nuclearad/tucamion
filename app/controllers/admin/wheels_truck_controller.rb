class Admin::WheelsTruckController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb = add_breadcrumb 'Quinta Rueda', :admin_wheels_truck_index_path, :options => {:title => 'Inicio'}

  def index
    @wheels = WheelsTruck.all
    @search = @wheels.search(params[:q])
    @wheels_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @wheel = WheelsTruck.new
    add_breadcrumb 'Agregar'
  end

  def create

    @wheel = WheelsTruck.new(allowed_params)
    if @wheel.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_wheels_truck_index_path
    else
      render 'new'
    end


  end

  def edit
    @wheel = WheelsTruck.find(params[:id])
    add_breadcrumb 'Editar'
  end

  def update

    @wheel = WheelsTruck.find(params[:id])

    if @wheel.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_wheels_truck_index_path
    else
      render :edit
    end


  end

  def destroy

    @wheel = WheelsTruck.find(params[:id])
    if @wheel.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_wheels_truck_index_path
    else
      render 'new'
    end


  end



  private
  def allowed_params
    params.require(:wheels_truck).permit!
  end


end
