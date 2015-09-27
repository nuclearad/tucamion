class Admin::OfferscustomersController < ApplicationController


  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Clientes', :admin_customers_path, :options => { :title =>'Inicio' }

  def index
    @offers = Offercustomer.where(:customer_id => params[:customer_id])
    @user = Customer.find_by_id(params[:customer_id])
    add_breadcrumb 'Planes'
  end

  def new
    @offer = Offercustomer.new
    add_breadcrumb 'Planes'
  end

  def create

    params[:offercustomer][:customer_id] =  params[:customer_id]
    @offer = Offercustomer.new(allowed_params)
    if @offer.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_customers_path
    else
      render 'new'
    end

  end

  def edit
  add_breadcrumb 'Editar'
  end

  def update
  end

  def destroy
  end

  private
  def allowed_params
    #params.require(:truck).permit(:nombre, :quintarueda)
    params.require(:offercustomer).permit!
  end
end
