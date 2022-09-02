require 'rails_helper'

RSpec.feature "Timeline", type: :feature do
  scenario "Can submit posts and view them" do
    visit "/scoreboard"
    click_link "Return to Home Page"
    expect(page).to have_content("Hello, world!")
  end
end
