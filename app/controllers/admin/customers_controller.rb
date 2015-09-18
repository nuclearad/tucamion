class Admin::CustomersController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Clientes', :admin_customers_path, :options => { :title =>'Inicio' }



  def index
    @customers = Customer.all
    @search = @customers.search(params[:q])
    @query_search_field= 'name_or_cedula_cont'
    @customers_filter = @search.result.page(params[:page]).per(5)
  end

  def new


    @customer = Customer.new
    @customer.quantities.build
    add_breadcrumb 'Agregar'


  end

  def create

    @customer = Customer.new(allowed_params)
    if @customer.save
      plan = Offer.find_by(typeoffer: Environment::TYPE[:planes][:generico])
      Offercustomer.create(customer_id: @customer.id, offer_id: plan.id)
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_customers_path
    else
      render 'new'
    end

  end

  def edit
    
    @customer = Customer.find(params[:id])
  end

  def update

    @customer = Customer.find(params[:id])
    if @customer.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_customers_path
    else
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
