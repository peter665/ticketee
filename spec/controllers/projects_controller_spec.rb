require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  it 'handles a missing project correctly' do
    get :show, params: {id: "not-here"}

    expect(response).to redirect_to projects_path

    expect(flash[:danger]).to eq 'The project you were looking for could not be found.'
  end


  it "handles permission erors by redirecting to a safe place" do
    project =  FactoryBot.create :project
    allow(controller).to receive(:current_user)
    get :show, params: { id: project.id }

    expect(response).to redirect_to root_path
    expect(flash[:danger]).to eq "You aren't allowed to do that"
  end

end
