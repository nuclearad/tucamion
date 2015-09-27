class Admin::TipoCarroceriasController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Tipo Carroceria', :admin_tipo_carrocerias_path, :options => {:title => 'Inicio'}


  def index
    @tipos = TipoCarroceria.all
    @search = @tipos.search(params[:q])
    @tipos_filter = @search.result.page(params[:page]).per(5)
    logger.info 'Vengo al index'
    respond_to do |format|
      format.js {logger.info 'Respondo por js'; render layout: nil}
      format.html {}
    end
  end

  def new
    @tipo = TipoCarroceria.new
    add_breadcrumb 'Agregar'
  end

  def create

    @tipo = TipoCarroceria.new(allowed_params)
    if @tipo.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_tipo_carrocerias_path
    else
      render 'new'
    end


  end

  def edit
    @tipo = TipoCarroceria.find(params[:id])
    add_breadcrumb 'Editar'
  end

  def update

    @tipo = TipoCarroceria.find(params[:id])

    if @tipo.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_tipo_carrocerias_path
    else
      flash[:danger] = 'La Información no ha sido actualizada correctamente'
      render :edit
    end

  end

  def destroy

    @tipo = TipoCarroceria.find(params[:id])
    if @tipo.destroy
      flash[:notice] = 'Información eliminada correctamente'
    else
      flash[:danger] = 'La información  no se ha eliminado'
    end
    redirect_to admin_tipo_carrocerias_path
  end


  private
  def allowed_params
    params.require(:tipo_carroceria).permit!
  end

end
