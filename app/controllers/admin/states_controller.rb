class Admin::StatesController < ApplicationController

  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Departamentos', :admin_states_path, :options => { :title =>'Inicio' }


  def index
    @states = State.all
    @search = @states.search(params[:q])
    @states_filter = @search.result.page(params[:page]).per(5)
  end

  def new
    @state = State.new
    add_breadcrumb 'Agregar'
  end

  def create

    @state = State.new(allowed_params)
    if @state.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_states_path
    else
      render 'new'
    end

  end

  def edit
    @state = State.find(params[:id])
  end

  def update


    @state = State.find(params[:id])
    if @state.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_states_path
    else
      render 'new'
    end



  end

  def destroy


    @state = State.find(params[:id])
    if @state.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_states_path
    else
      render 'new'
    end


  end


  private
  def allowed_params
    params.require(:state).permit(:name)
  end
end
