class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update, :destroy]

  def index
    @applications = Application.all
    render json: @applications.as_json(except: [:id])
  end

  def show
    render json: @application.as_json(except: [:id])
  end

  def create
    @application = Application.new(application_params)
    @application.chats_count = 0
    if @application.save
      render json: @application, status: :created, location: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def update
    if @application.update(application_params)
      render json: @application.as_json(except: [:id])
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @application.destroy
  end

  private
    def set_application
      @application = Application.where(access_token: params[:id])
    end

    def application_params
      params.require(:application).permit(:name)
    end
end