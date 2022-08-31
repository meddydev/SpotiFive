require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      email: "Email",
      name: "Name",
      image_url: "Image Url",
      total_score: 2,
      num_games: 3,
      auth_token: "Auth Token",
      refresh_token: "Refresh Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Image Url/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Auth Token/)
    expect(rendered).to match(/Refresh Token/)
  end
end
