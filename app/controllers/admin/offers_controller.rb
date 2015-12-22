class Admin::OffersController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Planes', :admin_offers_path, :options => { :title =>'Inicio' }


  def index
    @planes = Offer.where.not(typeoffer: 2)
    @search = @planes.search(params[:q])
    @planes_filter = @search.result.page(params[:page]).per(5)
    @query_search_field= 'nombre_cont'
  end

  def new

    @plan = Offer.new
    add_breadcrumb 'Agregar'


  end

  def create


    @plan = Offer.new(allowed_params)
    if @plan.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_offers_path
    else
      render 'new'
    end


  end

  def edit
    @plan = Offer.find(params[:id])
    add_breadcrumb 'Editar'
  end

  def update

    @plan = Offer.find(params[:id])
    if @plan.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_offers_path
    else
      render 'edit'
    end


  end

  def destroy 
    @plan = Offer.find_by(id: params[:id])
    if @plan && @plan.destroy
      flash[:notice] = 'Información fue eliminada correctamente'
      redirect_to admin_offers_path
    else
      flash[:error] = 'Error al eliminar la informacion'
      redirect_to admin_offers_path
    end    
  end

  private
  def allowed_params
    params.require(:offer).permit!
  end


end
