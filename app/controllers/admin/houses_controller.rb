class Admin::HousesController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Banners home', :admin_houses_path, :options => { :title =>'Inicio' }



  def index
    @banners = House.all

  end

  def new
    @banner = House.new
    add_breadcrumb 'Agregar'
  end

  def create

    @banner = House.new(allowed_params)
    if @banner.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_houses_path
    else
      render 'new'
    end
  end

  def edit

    @banner = House.find(params[:id])
  end

  def update


    @banner = House.find(params[:id])

    if @banner.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_houses_path
    else
      render 'new'
    end


  end

  def destroy

    @banner = House.find(params[:id])
    if @banner.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_houses_path
    else
      render 'new'
    end


  end

  private
  def allowed_params
    params.require(:house).permit!
  end

end
