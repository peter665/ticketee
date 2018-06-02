require "rails_helper"

RSpec.feature "Admins can edit users" do
  let(:admin) { FactoryBot.create :user, :admin }
  let(:user)  { FactoryBot.create :user }

  before do
    login_as admin
    visit admin_user_path(user)
    click_link "Edit User"
  end

  scenario "with valid details" do
    fill_in "Email", with: "newguy@example.com"
    click_button "Update User"

    expect(page).to have_content "User has been updated."
    expect(page.current_url).to eq admin_user_url(user)
    expect(page).to have_content "newguy@example.com"
    expect(page).not_to have_content user.email
  end

  scenario "when toggling a users's admin ability" do
    check "Is an admin?"
    click_button "Update User"

    expect(page).to have_content "#{user.email} (Admin)"
  end
end
