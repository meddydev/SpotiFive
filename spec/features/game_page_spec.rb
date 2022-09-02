require "rails_helper"

RSpec.feature "Game Page", type: :feature do
  scenario "should be successful" do
    visit "/game"

    click_button "Create User"
    expect(page).to havecontent("")
  end

  scenario "use fields to input game data" do
    visit "/game"

    expect(page).has_field? ("1").to equal (true)
  end

  scenario "has name in field" do
    visit "/game"

    expect(page).has_field?("Name", with: "Drake")
  end

  scenario "Can submit button directing to results" do
    visit "/game"

    expect(page).has_button?("Submit")
  end
end
