require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, Game.new(
      user_id: 1,
      artist_id: "MyString",
      artist_name: "MyString",
      score: 1
    ))
  end

  it "renders new game form" do
    render

    assert_select "form[action=?][method=?]", games_path, "post" do

      assert_select "input[name=?]", "game[user_id]"

      assert_select "input[name=?]", "game[artist_id]"

      assert_select "input[name=?]", "game[artist_name]"

      assert_select "input[name=?]", "game[score]"
    end
  end
end
