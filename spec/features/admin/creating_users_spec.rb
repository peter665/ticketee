require 'rails_helper'

RSpec.feature "Admins can create users" do
  let(:admin) { FactoryBot.create :user, admin:true }

  before do
    login_as admin
    visit '/'
    click_link "Admin"
    click_link "Users"
    click_link "New User"
  end

  scenario "with valid credentials" do
    fill_in "Email", with: "newbie@example.com"
    fill_in "Password", with: 'password'
    click_button "Create User"
    expect(page).to have_content "User has been created."
  end

  scenario " - admin users" do
    fill_in "Email", with: 'admin2@ticketee.com'
    fill_in "Password", with: 'password'
    check "Is an admin?"
    click_button "Create User"
    expect(page).to have_content "User has been created."
    expect(page).to have_content "admin2@ticketee.com (Admin)"
  end
end
