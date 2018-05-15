require 'rails_helper'

RSpec.describe User, type: :model do

	it "has a valid factory" do
		expect(build(:user).save).to be true
	end

	it "is invalid without an email" do
		expect(build(:user, email: nil).save).to be false
	end

	it "is invalid without a unique email address" do
		user = create(:user)
		expect(build(:user, email: user.email).save).to be false
	end

	it "is invalid with a password less than 6 characters" do
		expect(build(:user, password: "123", password_confirmation: "123").save).to be false
	end

end

