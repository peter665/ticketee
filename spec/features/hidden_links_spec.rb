require 'rails_helper'

RSpec.feature "Users can only see the appropriate links" do
  let(:user)    { FactoryBot.create :user }
  let(:admin)   { FactoryBot.create :user, admin:true }
  let(:project) { FactoryBot.create :project }

  context "anonymous users" do
    scenario "can not see the New Project link" do
      visit '/'
      expect(page).not_to have_link "New Project"
    end
  end

  context "non-asmin users (project viewers)" do
    before do
      login_as user
      assign_role! user, :viewer, project
    end

    scenario "can not see the New Project link" do
      visit '/'
      expect(page).not_to have_link "New Project"
    end

    scenario "can not see the Delete Project link" do
      visit project_path project
      expect(page).not_to have_link "Delete Project"
    end
  end

  context "admin users" do
    before do
      login_as admin
      assign_role! admin, :viewer, project
    end
    scenario "can see the New Project link" do
      visit '/'
      expect(page).to have_link "New Project"
    end

    scenario "can see the Delete Project link" do
      visit project_path project
      expect(page).to have_link "Delete Project"
    end
  end
end
