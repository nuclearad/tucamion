class Admin::CustomersController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Clientes', :admin_customers_path, :options => { :title =>'Inicio' }



  def index

    @customers = Customer.all
    @search = @customers.search(params[:q])
    @customers_filter = @search.result.page(params[:page]).per(5)
  end

  def new


    @customer = Customer.new
    @offers   = Offer.where(typeoffer: Environment::TYPE[:planes][:generico])
    @customer.quantities.build
    add_breadcrumb 'Agregar'


  end

  def create




    @customer = Customer.new(allowed_params)
    if @customer.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_customers_path
    else
      @offers = Offer.where(typeoffer: Environment::TYPE[:planes][:generico])
      render 'new'
    end



  end

  def edit
    @offers   = Offer.where(typeoffer: Environment::TYPE[:planes][:generico])
    @customer = Customer.find(params[:id])
  end

  def update

    @customer = Customer.find(params[:id])
    if @customer.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_customers_path
    else
      @offers = Offer.where(typeoffer: Environment::TYPE[:planes][:generico])
      render 'edit'
    end

  end

  def destroy

    @customer = Customer.find(params[:id])
    if @customer.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_customers_path
    else
      render 'new'
    end



  end



  private
  def allowed_params

    params.require(:customer).permit!
  end
end
