class Api::UsersController < ApplicationController

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

	private

	def user_params
		params.permit(
			:email,
			:password
		)
	end

end
