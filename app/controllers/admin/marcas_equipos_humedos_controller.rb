class Admin::MarcasEquiposHumedosController < ApplicationController



  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb = add_breadcrumb 'Marca Equipos Humedos', :admin_marcas_equipos_humedos_path, :options => {:title => 'Inicio'}


  def index
    @marcas = MarcaEquipoHumedo.all
    @search = @marcas.search(params[:q])
    @marcas_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @marca = MarcaEquipoHumedo.new
    add_breadcrumb 'Agregar'
  end

  def create

    @marca = MarcaEquipoHumedo.new(allowed_params)
    if @marca.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_marcas_equipos_humedos_path
    else
      render 'new'
    end


  end

  def edit
    @marca = MarcaEquipoHumedo.find(params[:id])
  end

  def update

    @marca = MarcaEquipoHumedo.find(params[:id])

    if @marca.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_marcas_equipos_humedos_path
    else
      render 'new'
    end


  end

  def destroy

    @marca = MarcaEquipoHumedo.find(params[:id])
    if @marca.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_marcas_equipos_humedos_path
    else
      render 'new'
    end
  end


  private
  def allowed_params
    params.require(:marca_equipo_humedo).permit!
  end

end
