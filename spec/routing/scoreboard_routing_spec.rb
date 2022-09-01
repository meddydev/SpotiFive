require "rails_helper"

RSpec.describe ScoreboardController, type: :routing do
  describe "routing" do
    it "routes to /scoreboard" do
      expect(get: "/scoreboard").to route_to("scoreboard#index")
    end
  end
end
