require 'rails_helper'
require 'factory_bot'

RSpec.describe "Pings", type: :request do
  include Warden::Test::Helpers

  it "return a status of 200" do
    get "/ping"
    expect(response).to have_http_status 200
  end

  it "returns a status of 401 if not logged in" do
    get "/ping/auth/"
    expect(response).to have_http_status 401
  end

  context "with an existing user" do
    context "authenticated through site" do
      let(:user) { create :user }
      let(:headers) { get_headers_http_cookie(user.email) }

      it "returns a status of 200 if logged in" do
        get "/ping/auth", headers: headers
        expect(response).to have_http_status 200
      end
    end

    context "when authenticated through native app" do
      let(:user) { create :user }
      let(:headers) { get_headers(user.email) }

      it "returns a status of 200 if logged in" do
        get "/ping/auth/", headers: headers
        expect(response).to have_http_status 200
      end
    end
  end
end
