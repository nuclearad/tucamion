class Admin::BannersController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Banners', :admin_banners_path, :options => { :title =>'Inicio' }




  def index
    @banners = Banner.all
    @search = @banners.search(params[:q])
    @banners_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @banner = Banner.new
    add_breadcrumb 'Agregar'

  end

  def create

    @banner = Banner.new(allowed_params)
    if @banner.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_banners_path
    else
      render 'new'
    end
  end

  def edit

    @banner = Banner.find(params[:id])
  end

  def update


    @banner = Banner.find(params[:id])

    if @banner.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_banners_path
    else
      render 'new'
    end


  end

  def destroy

    @banner = Banner.find(params[:id])
    if @banner.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_banners_path
    else
      render 'new'
    end


  end

  private
  def allowed_params
    params.require(:banner).permit!
  end




end
