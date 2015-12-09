class InboxController < ApplicationController
  #solos e hace para los clientes
  def index
    @user = Customer.find_by_id(session[:user])
    if @user
      @messages = @user.list_messages
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
        @truck = Truck.find_by_id(@message.item)
        Customer::CustomerMailer.inbox_message(@message, @truck).deliver
        redirect_to camion_path(@message.item, @truck.link_rewrite), flash: {success: "Se envio el mensaje al propietario del anuncio"}
      when "2" #repuesto 
        @extra = Extra.find_by_id(@message.item)
        Customer::CustomerMailer.inbox_message(@message, @extra).deliver
        redirect_to repuesto_path(@message.item, @extra.link_rewrite), flash: {success: "Se envio el mensaje al propietario del anuncio"}
      when "3" #servicio
        @service = Service.find_by_id(@message.item)
        Customer::CustomerMailer.inbox_message(@message, @service).deliver
        redirect_to servicio_path(@message.item, @service.link_rewrite), flash: {success: "Se envio el mensaje al propietario del anuncio"}
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
    @user = Customer.find_by_id(session[:user])
    if @user
      @message = Message.find_by(id: params[:id], customer_id:  @user.id)
      @message.destroy
      redirect_to inbox_index_path
    else
      render '/pages/micuentalogin', :layout => 'layouts/devise'
    end

  end

  def show
    @user = Customer.find_by_id(session[:user])
    if @user
      @message = Message.find_by(id: params[:id], customer_id:  @user.id)
      @message.status = Environment::STATUS[:mensajes][:inactivo]
      @message.save
      render :layout => 'layouts/cliente'
    else
      render '/pages/micuentalogin', :layout => 'layouts/devise'
    end
  end
  
  private
    def allowed_params
      params.require(:message).permit!
    end
end
