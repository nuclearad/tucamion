class Admin::CitiesController < ApplicationController

  before_action :authenticate_user!, :except => [:consulta,:index]
  layout  'admin/layouts/application'
  add_breadcrumb 'Departamentos', :admin_states_path, :options => { :title =>'Inicio' }


  def index
    @cities = City.where(state_id: params[:state_id]).order(:name).all
    @state = State.find_by_id(params[:state_id])
    add_breadcrumb @state.name
    respond_to do |format|
      format.html
      format.json  { render :json => @cities }
    end


  end

  def new



    @state = State.find_by_id(params[:state_id])
    @city = City.new(:state_id => @state)
    add_breadcrumb @state.name, :admin_state_cities_path, :options => { :title =>'Inicio' }

  end

  def create

    @city = City.new(allowed_params)
    @city.state_id = params[:state_id]
    if @city.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_state_cities_path
    else
      render 'new'
    end

  end

  def edit

    @city = City.find(params[:id])
    @state = State.find_by_id(params[:state_id])
    add_breadcrumb @state.name, :admin_state_cities_path, :options => { :title =>'Inicio' }
    add_breadcrumb 'Editar'
  end

  def update


    @city = City.find(params[:id])
    if @city.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_state_cities_path
    else
      render 'new'
    end



  end

  def destroy
  end



  private
  def allowed_params
    params.require(:city).permit(:name,:state_id)
  end
end
