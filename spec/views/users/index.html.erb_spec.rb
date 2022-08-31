require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        email: "Email",
        name: "Name",
        image_url: "Image Url",
        total_score: 2,
        num_games: 3,
        auth_token: "Auth Token",
        refresh_token: "Refresh Token"
      ),
      User.create!(
        email: "Email",
        name: "Name",
        image_url: "Image Url",
        total_score: 2,
        num_games: 3,
        auth_token: "Auth Token",
        refresh_token: "Refresh Token"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Image Url".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Auth Token".to_s, count: 2
    assert_select "tr>td", text: "Refresh Token".to_s, count: 2
  end
end
