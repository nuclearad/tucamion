class Admin::SpacesTruckController < ApplicationController


  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Tipo Cupo', :admin_spaces_truck_index_path, :options => {:title => 'Inicio'}


  def index
    @spaces = SpacesTruck.all
    @search = @spaces.search(params[:q])
    @spaces_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @space = SpacesTruck.new
    add_breadcrumb 'Agregar'
  end

  def create

    @space = SpacesTruck.new(allowed_params)
    if @space.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_spaces_truck_index_path
    else
      render 'new'
    end


  end

  def edit
    @space = SpacesTruck.find(params[:id])
    add_breadcrumb 'Editar'
  end

  def update
    @space = SpacesTruck.find(params[:id])
    if @space.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_spaces_truck_index_path and return
    else
      render :edit
    end

  end

  def destroy
    @space = SpacesTruck.find(params[:id])
    if @space.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_spaces_truck_index_path
    end

  end



  private
  def allowed_params
    params.require(:spaces_truck).permit!
  end
end
