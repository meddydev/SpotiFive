require "rails_helper"

RSpec.describe "home", type: :feature do
  scenario "Correct homepage scaffold is displayed" do
    visit "/home"

    expect(page).to have_content("Welcome back")
    expect(page.has_button?("Play")).to equal(true)
    expect(page.has_button?("Scoreboard")).to equal(true)
    expect(page).to have_content("Your recent scores")
  end

  # following tests will fail until other routes are merged
  scenario "clicking 'Play' redirects to /game page" do
    visit "/home"

    click_button("Play")
    expect(page).to have_current_path("/game")
  end

  scenario "clicking 'Scoreboard' redirects to /scoreboard page" do
    visit "/home"

    click_button("Scoreboard")
    expect(page).to have_current_path("/scoreboard")
  end
end
