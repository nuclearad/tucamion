class Admin::ContractsTruckController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb = add_breadcrumb 'Colores', :admin_contracts_truck_index_path, :options => {:title => 'Inicio'}
  add_breadcrumb


  def index
    @contracts = ContractsTruck.all
    @search = @contracts.search(params[:q])
    @contracts_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @contract = ContractsTruck.new
    add_breadcrumb 'Agregar'
  end

  def create
    @contract = ContractsTruck.new(allowed_params)
    if @contract.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_contracts_truck_index_path
    else
      render 'new'
    end
  end

  def edit
    @contract = ContractsTruck.find(params[:id])
  end

  def update

    @contract = ColorsTruck.find(params[:id])

    if @contract.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_contracts_truck_index_path
    else
      render 'new'
    end


  end

  def destroy

    @contract = ContractsTruck.find(params[:id])
    if @contract.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_contracts_truck_index_path
    else
      render 'new'
    end

  end



  private
  def allowed_params
    params.require(:contracts_truck).permit!
  end


end
