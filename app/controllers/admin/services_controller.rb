class Admin::ServicesController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Servicios', :admin_services_path, :options => { :title =>'Inicio' }



  def index
    @services = Service.all
  end

  def new

    @service = Service.new
    add_breadcrumb 'Agregar'


  end

  def create

    @service = Service.new(allowed_params)
    if @service.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_services_path
    else
      render 'new'
    end



  end

  def edit
    @service = Service.find(params[:id])
  end

  def update


    @service = Service.find(params[:id])

    if @service.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_services_path
    else
      render 'new'
    end



  end

  def destroy

    @service = Service.find(params[:id])
    if @service.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_services_path
    else
      render 'new'
    end


  end


  private
  def allowed_params
    #params.require(:truck).permit(:nombre, :quintarueda)
    params.require(:service).permit!
  end
end
