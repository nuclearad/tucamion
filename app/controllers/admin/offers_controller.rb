class Admin::OffersController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Clientes', :admin_offers_path, :options => { :title =>'Inicio' }


  def index

    @planes = Offer.all


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
  end

  def update

    @plan = Offer.find(params[:id])
    if @plan.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_offers_path
    else
      render 'new'
    end


  end

  def destroy
  end



  private
  def allowed_params
    params.require(:offer).permit!
  end


end
