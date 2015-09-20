class InboxController < ApplicationController
  def index
    @user = Customer.find_by_id(session[:user])
    if @user
      @messages = @user.messages.order(:status).desc
      render :layout => 'layouts/cliente'
    else
      render '/pages/micuentalogin', :layout => 'layouts/devise'
    end
  end

  def read
  	
  end

  def destroy
  end

  def show
  end
  
end
