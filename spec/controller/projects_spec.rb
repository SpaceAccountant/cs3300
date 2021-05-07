require "rails_helper"
require "auth_helper"

include AuthHelper

RSpec.describe ProjectsController, type: :controller do
  context "GET #index" do
    it "returns a success response" do
      get :index
      expect( response ).to have_http_status :ok
    end
  end

  context "GET #show" do
    let!( :project ) { Project.create( title: "Title", body: "Body content" ) }
    it "returns a success response" do
      get :show, params: { id: project }
      expect( response ).to have_http_status :ok
    end
  end

  context "GET #new" do
    it "returns a success response for logged in user" do
      login_user
      get :new
      expect( response ).to have_http_status :ok
    end
  end

  context "GET #edit" do
    let!( :project ) { Project.create( title: "Title", body: "Body content" ) }
    it "returns a success response for logged in user" do
      login_user
      get :edit, params: { id: project }
      expect( response ).to have_http_status :ok
    end
  end

  context "POST #create" do
    let!( :create_param ) do { project: { title: "Title", body: "Body content" } } end
    before( :each ) do
      login_user
      post :create, params: create_param
    end

    it "returns a temporary redirect response for a logged in user" do
      # Check that the redirect to a GET method of another page was successful.
      expect( response ).to have_http_status :found
    end

    it "creates the project for a logged in user" do
      expect( Project.count ).to eq( 1 )
      expect( Project.find( 1 ).title ).to eq( "Title" )
      expect( Project.find( 1 ).body ).to eq( "Body content" )
    end
  end

  context "PATCH #update" do
    let!( :created_project ) { Project.create( title: "Title", body: "Body content" ) }
    let!( :update_param ) do { id: created_project, project: { title: "Updated title", body: "Updated body content" } } end
    before( :each ) do
      login_user
      patch :update, params: update_param
    end

    it "returns a temporary redirect response for a logged in user" do
      # Check that the redirect to a GET method of another page was successful.
      expect( response ).to have_http_status :found
    end

    it "updates the project for a logged in user" do
      expect( Project.count ).to eq( 1 )
      expect( Project.find( 1 ).title ).to eq( "Updated title" )
      expect( Project.find( 1 ).body ).to eq( "Updated body content" )
    end
  end

  context "DELETE #destroy" do
    let!( :project ) { Project.create( title: "Title", body: "Body content" ) }
    before( :each ) do
      login_user
      delete :destroy, params: { id: project }
    end

    it "returns a temporary redirect response for a logged in user" do
      # Check that the redirect to a GET method of another page was successful.
      expect( response ).to have_http_status :found
    end

    it "destroys the project for a logged in user" do
      expect( Project.count ).to eq( 0 )
    end
  end
end
