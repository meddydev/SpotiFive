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

    click_on "home"
    visit "/home"
    expect(page).to have_content("")
  end

  scenario "checks on personal scoreboard" do
    visit "/game"

    click_on "scoreboard"
    visit "/scoreboard"
    expect(page).to have_content("")
  end

  scenario "user wants to end session" do
    visit "/game"

    click_on "logout"
    visit ""
    expect(page).to have_content("")
  end
end
