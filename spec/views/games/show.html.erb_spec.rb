require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      user_id: 2,
      artist_id: "Artist",
      artist_name: "Artist Name",
      score: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Artist/)
    expect(rendered).to match(/Artist Name/)
    expect(rendered).to match(/3/)
  end
end
