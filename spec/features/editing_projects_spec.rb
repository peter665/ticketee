require 'rails_helper'

RSpec.feature('Users can edit existing projects') do
  let(:author) { FactoryBot.create :user }

  before do
    login_as author
    @project = FactoryBot.create(:project, name:"Sublime Text 3")
    assign_role! author, :viewer, @project
    visit "/"
    click_link "Sublime Text 3"
    click_link "Edit Project"
  end

  scenario('with valid attributes') do
    fill_in 'Name', with: 'Atom'
    click_button 'Update Project'
    expect(page).to have_content 'Project has been updated.'
    expect(page).to have_content 'Atom'
  end

  scenario('when providing invalid attriburtes') do
    fill_in 'Name', with:''
    click_button 'Update Project'
    expect(page).to have_content 'Project has not been updated.'
    expect(page.current_url).to eq project_url(@project)
  end
end
