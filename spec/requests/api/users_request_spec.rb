require 'rails_helper'

RSpec.describe Api::UsersController, type: :request do

	let!(:users) { create_list(:user, 5) }
	let(:user) { users.last }

	describe "GET index" do

		before { get api_users_path }

		it "returns JSON" do
			puts
			expect(response.content_type).to eq("application/json")
		end

		it "returns status code 200" do
			expect(response).to have_http_status(200)
		end

	  it "returns all users" do
			expect(json.size).to eq(5)
		end

	end

	describe "GET show" do

		context "valid user" do

			before { get "/api/users/#{user.id}" }

			it "returns JSON" do
				expect(response.content_type).to eq("application/json")
			end

			it "returns the correct user" do
				expect(json["id"]).to eq(user.id)
			end

		end

		context "invalid user" do

			before { get "/api/users/0" }

			it "returns JSON" do
				expect(response.content_type).to eq("application/json")
			end

			it "returns status code 404" do
				expect(response).to have_http_status(404)
			end

		end

	end

	describe "POST create" do

		context "with a valid user" do

			it "returns a successful status (201) if properly created" do
				user_attributes = attributes_for :user
				expect {
					post "/api/users", params: user_attributes
				}.to change(User, :count).by(1)

				expect(response.status).to eq(201)
			end

			it "returns a successfully created json" do
				user_attributes = attributes_for :user
				post "/api/users", params: user_attributes
				expect(json["username"]).to eq(user_attributes[:username])
			end

		end

		context "with an invalid user" do

			it "returns an error with an invalid user" do
				expect {
					post "/api/users", params: { user: "wrong params" }
				}.to_not change(User, :count)

				expect(response.status).to eq(422)
			end

			it "returns json with errors" do
				post "/api/users", params: { user: "wrong params" }
				expect(json["errors"]).to_not be_empty
			end

		end

	end

end
