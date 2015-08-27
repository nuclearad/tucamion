class Admin::TipoCarroceriasController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb = add_breadcrumb 'Tipo Carroceria', :admin_tipo_carrocerias_path, :options => {:title => 'Inicio'}


  def index
    @tipos = TipoCarroceria.all
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
  end

  def update

    @tipo = TipoCarroceria.find(params[:id])

    if @tipo.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_tipo_carrocerias_path
    else
      render 'new'
    end


  end

  def destroy

    @tipo = TipoCarroceria.find(params[:id])
    if @tipo.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_tipo_carrocerias_path
    else
      render 'new'
    end
  end


  private
  def allowed_params
    params.require(:tipo_carroceria).permit!
  end

end
