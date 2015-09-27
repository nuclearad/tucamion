class Admin::MarcaVolcosController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Marca Volcos', :admin_marca_volcos_path, :options => {:title => 'Inicio'}


  def index
    @marcas = MarcaVolco.all
    @search = @marcas.search(params[:q])
    @marcas_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @marca = MarcaVolco.new
    add_breadcrumb 'Agregar'
  end

  def create

    @marca = MarcaVolco.new(allowed_params)
    if @marca.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_marca_volcos_path
    else
      render 'new'
    end


  end

  def edit
    @marca = MarcaVolco.find(params[:id])
    add_bredcrumb 'Editar'
  end

  def update

    @marca = MarcaVolco.find(params[:id])

    if @marca.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_marca_volcos_path
    else
      render :edit
    end


  end

  def destroy
    @marca = MarcaVolco.find(params[:id])
    if @marca.destroy
      flash[:notice] = 'Información eliminada correctamente'
    else
      flash[:notice] = 'La Información no se ha eliminado'
    end
    redirect_to admin_marca_volcos_path
  end


  private
  def allowed_params
    params.require(:marca_volco).permit!
  end


end
