class Api::UsersController < ApplicationController
	skip_before_action :authenticate_request, only: [:login]

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.create!(user_params)
		render status: :created
	end

	def login
		@token = AuthenticateUser.call(user_params[:email], user_params[:password])
		render json: { token: @token.result }
	end

	private

	def user_params
		params.require(:user).permit(
			:email,
			:password
		)
	end

end
