require "rails_helper"

RSpec.describe "Playing Game", type: :feature do
  scenario "User Inputs" do
    visit "/game"
    fill_in "", with: ""
    click_on "Submit"
    visit "scoreboard"
    expect(page).to have_content("")
  end

  scenario "end game abruptly" do
    visit "/game"
    fill_in "", with: ""
    click_on "home"
    visit "/home"
    expect(page).to have_content("")
  end

  # end

  # scenario "use fields to input game data" do
  #   visit "/game"

  #   expect(page).has_field? ("1").to equal (true)
  # end

  # scenario "has name in field" do
  #   visit "/game"

  #   expect(page).has_field?("Name", with: "Drake")
  # end

  # scenario "Can submit button directing to results" do
  #   visit "/game"

  #   expect(page).has_button?("Submit")
  # end
end
