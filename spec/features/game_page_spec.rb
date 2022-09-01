require "rails_helper"

RSpec.feature "Game Page", type: :feature do
  scenario "use fields to input game data" do
    visit "/game"
    # click_link "New post"
    # fill_in "Message", with: "Hello, world!"
    expect page.has_field? ("1").to equal (true)
  end

  # scenario "Can submit button directing to results" do
  #   visit "/game"
  #   # click_link "New post"
  #   # fill_in "Message", with: "Hello, world!"
  #   click_button "Submit"
  #   expect(page).to have_content("Hello, world!")
  # end
end
