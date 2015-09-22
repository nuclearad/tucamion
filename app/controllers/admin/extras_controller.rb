class Admin::ExtrasController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Repuestos', :admin_extras_path, :options => { :title =>'Inicio' }


  def index
    @search  = Extra.all.includes(:type_truck, :brand_extra, :state).search(params[:q])
    @extras  = @search.result.page(params[:page]).per(Environment::LIMIT_SEARCH)
  end

  def new

    @extra = Extra.new
    @horas = Environment::HORARIOS
    add_breadcrumb 'Agregar'

  end

  def create

    @extra = Extra.new(allowed_params)
    @extra.user_id = current_user.id

    if @extra.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_extras_path
    else
      @horas = Environment::HORARIOS
      render 'new'
    end


  end

  def edit

    @extra = Extra.find(params[:id])
    @horas = Environment::HORARIOS
  end

  def update
    @extra = Extra.find(params[:id])
    if @extra.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_extras_path
    else
      @horas = Environment::HORARIOS
      render 'edit'
    end
  end

  def destroy

    @extra = Extra.find(params[:id])
    if @extra.destroy
      flash[:notice] = 'Información eliminada correctamente'  
    else
      flash[:notice] = 'No se eliminada el elemento'
    end
    redirect_to admin_extras_path

  end

  private
  def allowed_params
    params.require(:extra).permit!
  end
end
