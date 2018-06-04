require "rails_helper"

RSpec.feature 'Users can create new tickets for projects' do
  let!(:user) { FactoryBot.create :user }

  before do
    login_as(user)
    @project = FactoryBot.create(:project, name: 'Internet Explorer')
    assign_role! user, :viewer, @project

    visit '/'
    click_link 'Internet Explorer'
    click_link 'New Ticket'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with:'Non standard compliance'
    fill_in 'Description', with: 'My pages are ugly!'
    click_button 'Create Ticket'

    ticket = Ticket.find_by name: "Non standard compliance"
    expect(page.current_url).to eq project_ticket_url(@project, ticket)
    expect(page).to have_content 'Ticket has been created.'
    within("#ticket") do
      expect(page).to have_content "Author: #{ user.email }"
    end
  end

  scenario 'with invalid attributes' do
    click_button 'Create Ticket'

    expect(page).to have_content 'Ticket has not been created.'
    expect(page.current_url).to eq project_tickets_url(@project)
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario 'with an invalid description' do
    fill_in 'Name', with: 'It is ugly.'
    fill_in 'Description', with: 'It sux'

    click_button 'Create Ticket'

    expect(page).to have_content 'Description must be at least 10 characters long.'
  end
end
