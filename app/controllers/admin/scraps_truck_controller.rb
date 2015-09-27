class Admin::ScrapsTruckController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Chatarrización', :admin_scraps_truck_index_path, :options => {:title => 'Inicio'}


  def index
    @scraps = ScrapsTruck.all
    @search = @scraps.search(params[:q])
    @scraps_filter = @search.result.page(params[:page]).per(5)
  end

  def new

    @scrap = ScrapsTruck.new
    add_breadcrumb 'Agregar'
  end

  def create

    @scrap = ScrapsTruck.new(allowed_params)
    if @scrap.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_scraps_truck_index_path
    else
      render 'new'
    end


  end

  def edit
    @scrap = ScrapsTruck.find(params[:id])
    add_breadcrum 'Editar'
  end

  def update

    @scrap = ScrapsTruck.find(params[:id])

    if @scrap.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_scraps_truck_index_path
    else
      render :edit
    end


  end

  def destroy

    @scrap = ScrapsTruck.find(params[:id])
    if @scrap.destroy
      flash[:notice] = 'Información eliminada correctamente'
    else
      flash[:notice] = 'No se eliminado el elemento'
    end

    redirect_to admin_scraps_truck_index_path
  end



  private
  def allowed_params
    params.require(:scraps_truck).permit!
  end


end
