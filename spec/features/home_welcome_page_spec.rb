require 'rails_helper'

RSpec.feature "home", type: :feature do
    scenario "Correct homepage scaffold is displayed" do
        visit "/home"

        expect(page).to have_content("Welcome back")
        expect(page.has_button?("Play")).to equal(true)
        expect(page.has_button?("Scoreboard")).to equal(true)
        expect(page).to have_content("Your recent scores")
    end
  
end