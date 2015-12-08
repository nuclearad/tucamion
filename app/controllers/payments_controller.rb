class PaymentsController < ApplicationController

  def comprar
    if session[:user].nil?
      session[:redirect] = comprar_path(params[:id])
      render '/pages/micuentalogin', :layout => 'layouts/devise'
    else
      @user = Customer.find(session[:user])
      @plan = Offer.find(params[:id])
      render :comprar
    end
  end

  def confirmacion
  end

  def respuesta
  end

end
