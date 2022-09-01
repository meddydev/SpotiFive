require 'rails_helper'

RSpec.feature "home", type: :feature do
    scenario "User can click Play" do
        visit "/home"

        expect(page).to have_content("Home")
      end

    #   scenario "User can click Play" do
    #     visit "/home"
    #     click_link "Play"

    #     expect(page).to have_content("Play")
    #   end

    
end