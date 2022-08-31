require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      email: "MyString",
      name: "MyString",
      image_url: "MyString",
      total_score: 1,
      num_games: 1,
      auth_token: "MyString",
      refresh_token: "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[image_url]"

      assert_select "input[name=?]", "user[total_score]"

      assert_select "input[name=?]", "user[num_games]"

      assert_select "input[name=?]", "user[auth_token]"

      assert_select "input[name=?]", "user[refresh_token]"
    end
  end
end
