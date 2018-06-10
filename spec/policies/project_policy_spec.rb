require 'rails_helper'

RSpec.describe ProjectPolicy do

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  context "policy_scope" do
    subject { Pundit.policy_scope user, Project }
    let(:project) { FactoryBot.create :project }
    let(:user)    { FactoryBot.create :user }

    it "is empty for anonymous users" do
      expect(Pundit.policy_scope(nil, Project)).to be_empty
    end

    it "includes projects a user is allowed to view" do
      assign_role!(user, :viewer, project)
      expect(subject).to include(project)
    end

    it "doesn't include projects a user is not allowed to view" do
      expect(subject).to be_empty
    end

    it "returns all projects for admins" do
      user.admin = true
      expect(subject).to include(project)
    end
  end

  permissions :show? do
    let(:user)    { FactoryBot.create :user }
    let(:project) { FactoryBot.create :project }

    it "blocks anonymous users" do
      expect(subject).not_to permit(nil, project)
    end

    it "allows viewers of the project" do
      assign_role!(user, :viewer, project)
      expect(subject).to permit(user, project)
    end

    it "allows editors of the project" do
      assign_role! user, :editor, project
      expect(subject).to permit user, project
    end

    it "allows managers of the project" do
      assign_role! user, :manager, project
      expect(subject).to permit user, project
    end

    it "allows administrators" do
      expect(subject).to permit((FactoryBot.create :user, :admin), project)
    end

    it "doesn't allow users assigned to other projects" do
      other_project = FactoryBot.create :project
      assign_role! user, :manager, other_project
      expect(subject).not_to permit user, project
    end
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
