class Admin::ColorsTruckController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb = add_breadcrumb 'Colores', :admin_colors_truck_index_path, :options => {:title => 'Inicio'}



  def index
    @colors = ColorsTruck.all
    @search = @colors.search(params[:q])
    @colors_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @color = ColorsTruck.new
    add_breadcrumb 'Agregar'
  end

  def create

    @color = ColorsTruck.new(allowed_params)
    if @color.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_colors_truck_index_path
    else
      render 'new'
    end


  end

  def edit
    @color = ColorsTruck.find(params[:id])
  end

  def update

    @color = ColorsTruck.find(params[:id])

    if @color.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_colors_truck_index_path
    else
      render 'new'
    end


  end

  def destroy

    @color = ColorsTruck.find(params[:id])
    if @color.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_colors_truck_index_path
    else
      render 'new'
    end
  end


  private
  def allowed_params
    params.require(:colors_truck).permit!
  end


end
