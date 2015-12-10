class PaymentsController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, only: [:respuesta, :confirmacion]

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
    begin

      referenceCode        = params[:reference_sale]
      response_message_pol = params[:response_message_pol]
      amount               = params[:value]
     
      #validar la firma
      if validate_sign
        payment = Payment.find_by(reference_code: referenceCode)
        if payment && response_message_pol == "APPROVED"
          plan = payment.offer
          user = payment.customer
          Offercustomer.create(customer_id: user.id, offer_id: plan.id)
          #deboeliminar el plan promocional para que el sistema no falle
          plan_free = user.offer.find_by(typeoffer: Environment::TYPE[:planes][:promocional])
          if plan_free
            offer_customer = Offercustomer.find_by(customer_id: user.id, offer_id: plan_free.id)
            offer_customer.destroy if offer_customer
          end
          payment.internal_status = 4 #aprobada
          payment.save
          Rails.logger.info("***Se ejecuto la confirmacion con exito***")
        end

      else
        Customer::CustomerMailer.error_payments_confirmation('Firma no valida al confirmar pago', referenceCode, response_message_pol, amount).deliver
      end
      render json: {code: 200}, status: 200
    rescue Exception => e
       Rails.logger.error("***************************Error en a confirmacion*********************************************")    
       Rails.logger.error("Referencia: #{referenceCode}")
       Rails.logger.error("Fecha: #{Time.now}")
       Rails.logger.error("Error: #{e.to_s}")
       Rails.logger.error('************************************************************************')
       Customer::CustomerMailer.error_payments_confirmation('Error al procesar pago', referenceCode, response_message_pol, amount).deliver
       render json: {code: 200}, status: 200
    end
  end

  def respuesta

    if session[:user].nil?
      @estadoTx = "El usuario no tiene session activa"
    else

      @user             = Customer.find session[:user]
      @apiKey           = Environment::APIKEY
      @merchant_id      = params[:merchantId]
      @referenceCode    = params[:referenceCode]
      @tx_value         = params[:TX_VALUE]
      @currency         = params[:currency]
      @transactionState = params[:transactionState]
      @signature        = params[:signature]
      @reference_pol    = params[:reference_pol]
      @cus              = params[:cus]
      @extra1           = params[:description]
      @pseBank          = params[:pseBank]
      @lapPaymentMethod = params[:lapPaymentMethod]
      @transactionId    = params[:transactionId]
      @payment          = Payment.find_by(reference_code: @referenceCode, customer_id: session[:user], internal_status: 0)
      
      if @payment
        case @transactionState
        when '4' #approved
          @payment.internal_status = 4
          @payment.gateway_status  = "Transacción aprobada"
          @color                   = 'green'
        when '6' #rejected
          @payment.internal_status = 6
          @payment.gateway_status  = "Transacción rechazada"
          @color                   = 'red'
        when '104' # error
          @payment.internal_status = 104
          @payment.gateway_status  = "Error"
          @color                   = 'red'
        when '7' #pending
          @payment.internal_status = 7
          @payment.gateway_status  = "Transacción pendiente"
          @color                   = 'gray'
        else
          @payment.gateway_status  = params[:mensaje]
          @payment.internal_status = 1
          @color                   = 'gray'
        end
        @payment.type_card = @lapPaymentMethod
        @payment.save
      end
    end

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
      @referencia = "Ref_#{Time.now.strftime('%y%m%d%H%M%S')}"
    end

    def generate_signature
      #"+calcular_precio.to_s+"
      sign      = Environment::APIKEY+"~"+Environment::MERCHANTID+"~"+@referencia+"~10000~"+Environment::CURRENCY
      signature = Digest::MD5.hexdigest(sign)
    end

    def validate_sign
      
      apikey         = Environment::APIKEY
      merchant_id    = params[:merchant_id]
      reference_sale = params[:reference_sale]
      new_value      = params[:value].to_f
      currency       = params[:currency]
      state_pol      = params[:state_pol]
      sign           = params[:sign]

      new_sign = Digest::MD5.hexdigest("#{apikey}~#{merchant_id}~#{reference_sale}~#{new_value}~#{currency}~#{state_pol}")
     
      if sign == new_sign
        true
      else
        false
      end
    
    end

end
