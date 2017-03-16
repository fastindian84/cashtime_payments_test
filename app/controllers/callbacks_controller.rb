class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    req = AppRequest.find_by!(order_uid: params[:order_uid])
    req.status = params[:status]
    req.response = params[:callback].permit!.to_h
    req.save
  end
end
