require 'net/http'

class AppRequestsController < ApplicationController
  before_action :set_app_request, only: [:show, :edit, :update, :destroy]

  # GET /app_requests
  # GET /app_requests.json
  def index
    @app_requests = AppRequest.all
  end

  # GET /app_requests/1
  # GET /app_requests/1.json
  def show
  end

  # GET /app_requests/new
  def new
    @app_request = AppRequest.new
  end

  # GET /app_requests/1/edit
  def edit
  end

  # POST /app_requests
  # POST /app_requests.json
  def create
    @app_request = AppRequest.new(app_request_params)
    @app_request.order_uid = SecureRandom.uuid

    tm_response = faraday.post do |req|
      req.url uri.path
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-API-KEY'] = @app_request.public_key
      req.body = @app_request.to_json
    end

    if tm_response.success? && @app_request.save
      redirect_to tm_response.body
    else
      errors = JSON.parse(tm_response.body)['errors']
      errors.each do |e|
        @app_request.errors.add(:base, e)
      end

      respond_to do |format|
        format.html {
          render :new, error: tm_response.body
        }
      end
    end
  end

  # PATCH/PUT /app_requests/1
  # PATCH/PUT /app_requests/1.json
  def update
    respond_to do |format|
      if @app_request.update(app_request_params)
        format.html { redirect_to @app_request, notice: 'App request was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_request }
      else
        format.html { render :edit }
        format.json { render json: @app_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_requests/1
  # DELETE /app_requests/1.json
  def destroy
    @app_request.destroy
    respond_to do |format|
      format.html { redirect_to app_requests_url, notice: 'App request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_request
      @app_request = AppRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_request_params
      params.require(:app_request).permit(:title, :description, :user_name, :image_url, :amount, :order_uid, :user_uid, :status, :response, :public_key, :app_id)
    end

    def faraday
      Faraday.new(uri)
    end

    def uri
      URI(ENV['cashtime_payments_url'])
    end
end
