require 'rails_helper'

RSpec.describe "User Login", type: :request do
  let!(:user) { User.create!(email: "test@example.com", password: "password123") }

  it "logs a user in with valid credentials" do
    post "/login", params: {
      email: "test@example.com",
      password: "password123"
    }

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to include("token")
  end

  it "fails with invalid credentials" do
    post "/login", params: {
      email: "test@example.com",
      password: "wrong"
    }

    expect(response).to have_http_status(:unauthorized)
  end
end
