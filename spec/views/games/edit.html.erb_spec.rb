require 'rails_helper'

RSpec.describe "games/edit", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      user_id: 1,
      artist_id: "MyString",
      artist_name: "MyString",
      score: 1
    ))
  end

  it "renders the edit game form" do
    render

    assert_select "form[action=?][method=?]", game_path(@game), "post" do

      assert_select "input[name=?]", "game[user_id]"

      assert_select "input[name=?]", "game[artist_id]"

      assert_select "input[name=?]", "game[artist_name]"

      assert_select "input[name=?]", "game[score]"
    end
  end
end
