class Admin::TypeExtraController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Marcas de repuesto', :admin_type_extra_index_path, :options => { :title =>'Inicio' }


  def index
    @types = TypeExtra.all
    @search = @types.search(params[:q])
    @types_filter = @search.result.page(params[:page]).per(5)
  end

  def new

    @type = TypeExtra.new
    add_breadcrumb 'Agregar'

  end

  def create

    @type = TypeExtra.new(allowed_params)
    if @type.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_type_extra_index_path
    else
      render 'new'
    end


  end

  def edit
    @type = TypeExtra.find(params[:id])
    add_breeadcrumnb 'Editar'
  end

  def update


    @type = TypeExtra.find(params[:id])

    if @type.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_type_extra_index_path
    else
      render 'new'
    end


  end

  def destroy

    @type = TypeExtra.find(params[:id])
    if @type.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_type_extra_index_path
    else
      render 'new'
    end


  end


  private
  def allowed_params
    params.require(:type_extra).permit(:name)
  end
end
