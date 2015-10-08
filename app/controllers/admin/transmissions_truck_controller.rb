class Admin::TransmissionsTruckController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb = add_breadcrumb 'Marcas Trasmisiones', :admin_transmissions_truck_index_path, :options => {:title => 'Inicio'}


  def index
    @transmissions = TransmissionsTruck.all
    @search = @transmissions.search(params[:q])
    @transmissions_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @transmission = TransmissionsTruck.new
    add_breadcrumb 'Agregar'
  end

  def create

    @transmission = TransmissionsTruck.new(allowed_params)
    if @transmission.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_transmissions_truck_index_path
    else
      render 'new'
    end


  end

  def edit
    @transmission = TransmissionsTruck.find(params[:id])
    add_breadcrumb 'Editar'
  end

  def update


    @transmission = TransmissionsTruck.find(params[:id])

    if @transmission.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_transmissions_truck_index_path
    else
      render :edit
    end

  end

  def destroy
    @transmission = TransmissionsTruck.find(params[:id])
    if @transmission.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_transmissions_truck_index_path
    else
      render 'new'
    end

  end



  private
  def allowed_params
    params.require(:transmissions_truck).permit!
  end
end
