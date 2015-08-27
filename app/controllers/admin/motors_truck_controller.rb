class Admin::MotorsTruckController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb = add_breadcrumb 'Tipo Cupo', :admin_motors_truck_index_path, :options => {:title => 'Inicio'}


  def index
    @motors = MotorsTruck.all
  end

  def new
    @motor = MotorsTruck.new
    add_breadcrumb 'Agregar'
  end

  def create
    @motor = MotorsTruck.new(allowed_params)
    if @motor.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_motors_truck_index_path
    else
      render 'new'
    end

  end

  def edit
    @motor = MotorsTruck.find(params[:id])
  end

  def update
    @motor = MotorsTruck.find(params[:id])

    if @motor.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_motors_truck_index_path
    else
      render 'new'
    end


  end

  def destroy

    @motor = MotorsTruck.find(params[:id])
    if @motor.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_motors_truck_index_path
    else
      render 'new'
    end


  end


  private
  def allowed_params
    params.require(:motors_truck).permit!
  end
end
