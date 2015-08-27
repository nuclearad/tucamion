class Admin::TypeServiceController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Tipo de servicio', :admin_type_service_index_path, :options => { :title =>'Inicio' }



  def index
    @types = TypeService.all
  end

  def new

    @type = TypeService.new
    add_breadcrumb 'Agregar'

  end

  def create

    @type = TypeService.new(allowed_params)
    if @type.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_type_service_index_path
    else
      render 'new'
    end



  end

  def edit

    @type = TypeService.find(params[:id])
  end

  def update


    @type = TypeService.find(params[:id])

    if @type.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_type_service_index_path
    else
      render 'new'
    end




  end

  def destroy

    @type = TypeService.find(params[:id])
    if @type.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_type_service_index_path
    else
      render 'new'
    end


  end


  private
  def allowed_params
    params.require(:type_service).permit(:name)
  end
end
