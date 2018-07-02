class ApplicationController < ActionController::Base
	before_action :authenticate_request
  protect_from_forgery with: :null_session

  attr_reader :current_user

  include ExceptionHandler

  private

  def authenticate_request
  	@current_user = AuthorizeApiRequest.call(request.headers).result
  	render json: { errors: 'Not Authorized' }, status: 401 unless @current_user
  end
end
