class InboxController < ApplicationController
  #solos e hace para los clientes
  def index
    @user = Customer.find_by_id(session[:user])
    if @user
      @messages = @user.messages.includes(:truck, :service, :extra).order(:status, :tipo)
      render :layout => 'layouts/cliente'
    else
      render '/pages/micuentalogin', :layout => 'layouts/devise'
    end
  end

  def create
    @message = Message.new(allowed_params)
    if @message.save
      case @message.tipo.to_s 
      when "1" #camion 
        redirect_to camion_path(@message.item, Truck.find_by_id(@message.item).link_rewrite), flash: {success: "Se envio el mensaje al propietario del anuncio"}
      when "2" #repuesto 
        redirect_to repuesto_path(@message.item, Extra.find_by_id(@message.item).link_rewrite), flash: {success: "Se envio el mensaje al propietario del anuncio"}
      when "3" #servicio
        redirect_to servicio_path(@message.item, Service.find_by_id(@message.item).link_rewrite), flash: {success: "Se envio el mensaje al propietario del anuncio"}
      end
    else
      case @message.tipo.to_s 
      when "1" #camion 
        @truck   = Truck.find_by_id(@message.item)
        @ciudad  = City.find_by_id(@truck.placa_city_id)
        render 'pages/camion'
      when "2" #repuesto
        @extra   = Extra.find_by_id(@message.item)
        render 'pages/repuesto'
      when "3" #servicio
        @service = Service.find_by_id(@message.item)
        render 'pages/servicio'
      end
    end
  end

  def destroy
    @message = Message.find_by_id params[:id]
    @message.destroy
    redirect_to inbox_index_path
  end

  def show
    @user = Customer.find_by_id(session[:user])
    @message = Message.find_by_id params[:id]
    @message.status = Environment::STATUS[:mensajes][:inactivo]
    @message.save
    render :layout => 'layouts/cliente'
  end
  
  private
    def allowed_params
      params.require(:message).permit!
    end
end
