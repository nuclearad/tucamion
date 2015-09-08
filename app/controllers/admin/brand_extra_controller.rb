class Admin::BrandExtraController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Tipo de repuesto', :admin_brand_extra_index_path, :options => { :title =>'Inicio' }


  def index
    @brands = BrandExtra.all
    @search = @brands.search(params[:q])
    @brands_filter = @search.result.page(params[:page]).per(5)
  end

  def new

    @brand = BrandExtra.new
    add_breadcrumb 'Agregar'


  end

  def create

    @brand = BrandExtra.new(allowed_params)

    if @brand.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_brand_extra_index_path
    else
      render 'new'
    end


  end

  def edit

    @brand = BrandExtra.find(params[:id])
    add_breadcrumb 'Editar'


  end

  def update


    @brand = BrandExtra.find(params[:id])

    if @brand.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_brand_extra_index_path
    else
      render 'new'
    end


  end

  def destroy


    @brand = BrandExtra.find(params[:id])
    if @brand.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_brand_extra_index_path
    else
      render 'new'
    end


  end


  private
  def allowed_params
    params.require(:brand_extra).permit(:name)
  end


end
