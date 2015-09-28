class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  respond_to :html
  layout  'admin/layouts/application'
  add_breadcrumb 'Administradores', :admin_users_path, :options => { :title =>'Inicio' }

  def index
    @admin_users = Admin::User.all
    respond_with(@admin_users)
  end

  def show
    respond_with(@admin_user)
  end

  def new
    @admin_user = Admin::User.new
    respond_with(@admin_user)
  end

  def edit
  end

  def create
    @admin_user = Admin::User.new(user_params)
    @admin_user.save
    respond_with(@admin_user)
  end

  def update
    @admin_user.update(user_params)
    respond_with(@admin_user)
  end

  def destroy
    @admin_user.destroy
    respond_with(@admin_user)
  end

  private
    def set_admin_user
      @admin_user = Admin::User.find(params[:id])
    end

    def admin_user_params
      params.require(:admin_user).permit(:email, :firstName, :lastName, :status)
    end
end
