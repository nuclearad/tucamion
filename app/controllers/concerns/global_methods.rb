module GlobalMethods
  extend ActiveSupport::Concern
  include ActionView::Helpers::NumberHelper

  public
   def redirect_pay=(value)
     session[:redirect] = value
   end

   def redirect_pay
     session[:redirect]
   end

end