class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  def index

    @trucks = Truck.all.count
    @extras = Extra.all.count
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



    if(params[:type] == 'service')
      @item = Service.find(params[:iditem])
      if(params[:idstate] == '0')
        @item.active = 1
      else
        @item.active = 0
      end
      if @item.save
        redirect_to admin_services_path
      end
    end



    if(params[:type] == 'truck')
      item = Truck.find(params[:iditem])
      puts item
      if(params[:idstate] == '0')
        item.update_attribute(:active, 1)
      else
        item.update_attribute(:active, 0)
      end
      if item.save

      end
      redirect_to admin_trucks_path
    end



    if(params[:type] == 'extra')
      @item = Extra.find(params[:iditem])
      if(params[:idstate] == '0')
        @item.active = 1
      else
        @item.active = 0
      end
      if @item.save
        redirect_to admin_extras_path
      end
    end


  end
end
