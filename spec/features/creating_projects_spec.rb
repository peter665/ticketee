require "rails_helper"

RSpec.feature "Users can create new projects" do
  scenario "with valid attributes" do
    visit "/"
    click_link "New Project"

    fill_in "Name", with: "Sublime text"
    fill_in "Description", with: "A text editor for everyone"
    click_button "Create project"

    expect(page).to have_content "Project has been created"
  end
end
