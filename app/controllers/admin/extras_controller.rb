class Admin::ExtrasController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Repuestos', :admin_extras_path, :options => { :title =>'Inicio' }


  def index

    @extras = Extra.all
    @search = @extras.search(params[:q])
    @extras_filter = @search.result.page(params[:page]).per(5)
  end

  def new

    @extra = Extra.new
    add_breadcrumb 'Agregar'

  end

  def create


    @extra = Extra.new(allowed_params)
    if @extra.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_extras_path
    else
      render 'new'
    end


  end

  def edit

    @extra = Extra.find(params[:id])
  end

  def update


    @extra = Extra.find(params[:id])

    if @extra.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_extras_path
    else
      render 'new'
    end



  end

  def destroy

    @extra = Extra.find(params[:id])
    if @extra.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_extras_path
    else
      render 'new'
    end


  end

  private
  def allowed_params
    params.require(:extra).permit!
  end
end
