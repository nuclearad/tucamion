class Admin::InboxController < ApplicationController
 
  before_action :authenticate_user!
  layout  'admin/layouts/application'
 
  def index
     @messages = current_user.list_messages
  end

  def destroy
    @message = Message.find_by(id: params[:id], user_id:  current_user.id)
    @message.destroy
    redirect_to admin_inbox_index_path
  end

  def show
    @message = Message.find_by(id: params[:id], user_id:  current_user.id)
    @message.status = Environment::STATUS[:mensajes][:inactivo]
    @message.save
  end

end
