class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  def index
    @trucks   = Truck.all.count
    @extras   = Extra.all.count
    @services = Service.all.count
  end



  def updatestatecustomer


    @item = Customer.find(params[:iditem])
    if(params[:idstate] == '0')
      @item.estado = 1
    else
      @item.estado = 0
    end
    if @item.save
      redirect_to admin_customers_path
    end



  end


  def updatestate
    
    case params[:type]
    when 'service'
      item = Service.find(params[:iditem])
      path = admin_services_path
    when 'truck'
      item = Truck.find(params[:iditem])
      path = admin_trucks_path
    when 'extra'
      item = Extra.find(params[:iditem])
      path = admin_extras_path
    end
    
    if(params[:idstate] == '1')
      item.update_attribute(:active, Environment::STATUS[:generico][:inactivo_admin])
    elsif(params[:idstate] == '3')
      item.update_attribute(:active, Environment::STATUS[:generico][:activo])
    end
  
    redirect_to path
  
  end

end
