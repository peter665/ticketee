require 'rails_helper'

RSpec.feature 'users can view tickets' do

  let(:author) { FactoryBot.create :user }

  before do
    sublime = FactoryBot.create(:project, name:'Sublime Text 3')
    assign_role! author, :viewer, sublime
    ticket = FactoryBot.create(:ticket, project: sublime,
              name: 'Make it shiny!',
              description: 'Gradients! Starburst! Oh my!')

    ie = FactoryBot.create(:project, name:'Internert Explorer')
    assign_role! author, :viewer, ie

    ticket = FactoryBot.create(:ticket, project: ie,
              name: 'Standards compliance',
              description: 'Is not a joke.')

    login_as author
    visit '/'
  end

  scenario 'for a given project' do
    click_link 'Sublime Text 3'

    expect(page).to have_content 'Make it shiny!'
    expect(page).to_not have_content 'Standards compliance'

    click_link 'Make it shiny!'
    within('#ticket h2') do
      expect(page).to have_content 'Make it shiny!'
    end
    expect(page).to have_content 'Gradients! Starburst! Oh my!'
  end
end
