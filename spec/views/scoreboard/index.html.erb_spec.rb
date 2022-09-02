require 'rails_helper'

RSpec.describe "scoreboard/index.html.erb", type: :view do
  
  
  before(:each) do
    assign(:users, [
      User.create!(
        email: "Email1",
        name: "Irina",
        image_url: "Image Url",
        total_score: 12,
        num_games: 23,
        auth_token: "Auth Token",
        refresh_token: "Refresh Token"
      ),
      User.create!(
        email: "Email",
        name: "Julien",
        image_url: "Image Url",
        total_score: 2,
        num_games: 3,
        auth_token: "Auth Token",
        refresh_token: "Refresh Token"
      )
    ])
  end

  it "renders the scores for both users" do
    render
    assert_select "h1", text: "Scoreboard", count: 1
    assert_select "tr>th", text: "Name".to_s, count: 1
    assert_select "tr>th", text: "Number of Games".to_s, count: 1
    assert_select "tr>th", text: "Total Score".to_s, count: 1
    assert_select "tr>th", text: "Average Score".to_s, count: 1
    assert_select "tr>td", text: 12.to_s, count: 1
    assert_select "tr>td", text: 2.to_s, count: 1
    assert_select "tr>td", text: 3.to_s, count: 1
    assert_select "tr>td", text: 23.to_s, count: 1
    assert_select "tr>td", text: 'Irina'.to_s, count: 1
    assert_select "tr>td", text: 'Julien'.to_s, count: 1
    assert_select "a", text: "Return to Home Page".to_s, count: 1
  end
end
