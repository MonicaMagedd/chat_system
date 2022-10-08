class ChatsController < ApplicationController
  before_action :set_application

  def index
    @chats = Chat.where(application_id: @application.id)
    render json: @chats.as_json(except: [:id, :application_id])
  end

  def show
    render json: @application.chats.where(number: params[:number]).as_json(except: [:id, :application_id])
  end

  def create
    chat_number = $redis.incr("chat_number_#{@application.access_token}")
    chat_parameters = {
      number: chat_number,
      application_id: @application.id,
      messages_count: 0,
      action: "create"
    }
    producer = ProducerHelper.new
    producer.send_message($chatQueue, chat_parameters)
    render json: {chat_number: chat_number, access_token: @application.access_token}
  end

  def update
    chat_params[:action] = "update"
    producer = ProducerHelper.new
    producer.send_message($chatQueue, chat_parameters)
    chat_number = $redis.get("chat_number_#{@application.access_token}")
    render json: {chat_number: chat_number, access_token: @application.access_token}
  end

  def destroy
    chat_number = $redis.decr("chat_number_#{@application.access_token}")
    @application.chats.find_by(number: params[:number]).destroy
  end

  private
    def set_application
      @application = Application.find_by!(access_token: params[:application_id])
    end

    def chat_params
      params.require(:chat).permit(:application_id)
    end
end