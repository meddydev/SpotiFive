require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(
        user_id: 2,
        artist_id: "Artist",
        artist_name: "Artist Name",
        score: 3
      ),
      Game.create!(
        user_id: 2,
        artist_id: "Artist",
        artist_name: "Artist Name",
        score: 3
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Artist".to_s, count: 2
    assert_select "tr>td", text: "Artist Name".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
