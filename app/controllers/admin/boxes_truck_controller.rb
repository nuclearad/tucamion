class Admin::BoxesTruckController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb = add_breadcrumb 'Marca Caja', :admin_boxes_truck_index_path, :options => {:title => 'Inicio'}



  def index
    @boxes = BoxesTruck.all
    @search = @boxes.search(params[:q])
    @boxes_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @box = BoxesTruck.new
    add_breadcrumb 'Agregar'
  end

  def create


    @box = BoxesTruck.new(allowed_params)
    if @box.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_boxes_truck_index_path
    else
      render 'new'
    end


  end

  def edit
    @box = BoxesTruck.find(params[:id])
  end

  def update

    @box = BoxesTruck.find(params[:id])

    if @box.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_boxes_truck_index_path
    else
      render 'new'
    end


  end

  def destroy

    @box = BoxesTruck.find(params[:id])
    if @box.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_boxes_truck_index_path
    else
      render 'new'
    end

  end


  private
  def allowed_params
    params.require(:boxes_truck).permit!
  end
end
