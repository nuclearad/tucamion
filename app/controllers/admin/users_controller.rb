class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  respond_to :html
  layout  'admin/layouts/application'
  add_breadcrumb 'Administradores', :admin_users_path, :options => { :title =>'Inicio' }

  def index
    @admin_users = User.all
    @search = @admin_users.search(params[:q])
    @query_search_field= 'first_name_or_last_name_or_email_cont'
    @admin_users_filter = @search.result.page(params[:page]).per(10)
    respond_with(@admin_users)
  end

  def show
    respond_with(@admin_user)
  end

  def new
    @admin_user = User.new
    add_breadcrumb 'Agregar'
    respond_with(@admin_user)
  end

  def edit
    add_breadcrumb 'Editar'
  end

  def create
    @admin_user = User.new(admin_user_params)
    @admin_user.password= 'aleatorio'
    if @admin_user.save
      flash[:notice]= 'Administrador Agregado Correctamente'      
    else
      flash[:danger]= 'No se agrego el registro'
    end
    redirect_to admin_users_path
  end

  def update
    
    if @admin_user.update_attributes(admin_user_params)
      flash[:notice]= 'Informacion Actualizada correctamente'
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @admin_user.destroy
      redirect_to admin_users_path
    end
  end

  private
    def set_admin_user
      @admin_user = User.find(params[:id])
    end

    def admin_user_params
      params.require(:user).permit(:email, :first_name, :last_name, :status)
    end
end
