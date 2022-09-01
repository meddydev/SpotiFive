require 'rails_helper'

RSpec.describe "Scoreboards", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/scoreboard/index"
      expect(response).to have_http_status(:success)
    end
  end

end
