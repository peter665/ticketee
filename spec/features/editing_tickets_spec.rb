require 'rails_helper'

RSpec.feature 'Users can edit tickets' do
  let(:project) { FactoryBot.create :project }
  let(:ticket) { FactoryBot.create :ticket, project: project }

  before do
    visit project_ticket_path(project, ticket)
    click_link 'Edit Ticket'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with:'Atom'

    click_button "Update Ticket"

    within("#ticket h2") do
      expect(page).to have_content "Atom"
    end
    expect(page).to have_content "Ticket has been updated."
  end

  scenario 'with invalid attributes' do
    fill_in 'Name', with: ''
    click_button "Update Ticket"

    expect(page).to have_content "Ticket has not been updated."
    expect(page).to have_content "Name can't be blank"
  end
end
