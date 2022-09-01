RSpec.feature "home", type: :feature do
    # scenario "User can click Play" do
    #   visit "/home"
    #   click_link "Play"
    #   fill_in "Message", with: "Hello, world!"
    #   click_button "Play"
    #   expect(page).to have_content("Hello, world!")
    # end

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