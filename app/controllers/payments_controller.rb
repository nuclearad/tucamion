class PaymentsController < ApplicationController

  def comprar
    if session[:user].nil?
      session[:redirect] = comprar_path(params[:id])
      render '/pages/micuentalogin', :layout => 'layouts/devise'
    else
      @user    = Customer.find(session[:user])
      @plan    = Offer.find(params[:id])
      @payment = Payment.create(customer_id:    @user.id, 
      	                        offer_id:       @plan.id,
      	                        reference_code: generate_reference, 
                                amount:         calcular_precio(), 
                                description:    "pago con TDC para el plan #{@plan.nombre}", 
                                signature:      generate_signature) #'Test PAYU'
      @old_pay = Payment.where('created_at <= ? AND internal_status = 0', Time.now - 20.minutes)
      if @old_pay.size > 0
        @old_pay.destroy_all     
      end
      render :comprar
    end
  end

  def confirmacion
  end

  def respuesta
  end

  private
    def calcular_precio
      if @user.typeuser == 0
         @plan.precio1
      else
         @plan.precio2
      end
    end
    
    def generate_reference
      @referencia = "REF#{Time.now.strftime('%y%m%d%H%M%S')}"
    end

    def generate_signature
      signature = Digest::MD5.hexdigest("#{Environment::APIKEY}#{Environment::MERCHANTID}#{@referencia}#{calcular_precio}#{Environment::CURRENCY}")
    end

end
