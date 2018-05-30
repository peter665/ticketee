require 'rails_helper'

RSpec.feature 'users can delete projects' do
  let(:admin) { FactoryBot.create :user, admin:true }
  before do
    login_as admin
  end

  scenario 'successfully' do
    FactoryBot.create(:project, name:'Sublime Text 3')
    visit "/"
    click_link 'Sublime Text 3'
    click_link 'Delete Project'
    expect(page).to have_content 'Project has been deleted.'
    expect(page.current_url).to eq projects_url
    expect(page).to have_no_content 'Sublime Text 3'
  end
end
