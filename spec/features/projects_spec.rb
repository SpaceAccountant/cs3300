require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  context "Read projects" do
    let!( :project ) { Project.create( title: "Test title", body: "Test body content" ) }
    before( :each ) do
      visit projects_path
    end

    scenario "should be successful" do
        expect( page ).to have_text( "Test title" )
        expect( page ).to have_text( "Test body content" )
    end
  end

  context "Create new project" do
    before( :each ) do
      visit new_project_path
    end

    scenario "should be successful" do
      within( "form" ) do
        fill_in "Title", with: "Title"
        fill_in "Body", with: "Body content"
      end
      click_button "Create Project"
      expect( page ).to have_content( "Project was successfully created." )
      expect( Project.count ).to eq( 1 )
      expect( Project.find( 1 ).title ).to eq( "Title" )
      expect( Project.find( 1 ).body ).to eq( "Body content" )
    end

    scenario "should fail with empty title" do
      within( "form" ) do
        fill_in "Title", with: ""
        fill_in "Body", with: "Body content"
      end
      click_button "Create Project"
      expect( page ).to have_content( "Title can't be blank." )
      expect( Project.count ).to eq( 0 )
    end

    scenario "should fail with empty body" do
      within( "form" ) do
        fill_in "Title", with: "Title content"
        fill_in "Body", with: ""
      end
      click_button "Create Project"
      expect( page ).to have_content( "Body can't be blank." )
      expect( Project.count ).to eq( 0 )
    end
  end

  context "Update project" do
    let!( :project ) { Project.create( title: "Title", body: "Body content" ) }
    before( :each ) do
      visit edit_project_path( project )
    end

    scenario "should be successful" do
      within( "form" ) do
        fill_in "Title", with: "Updated title"
        fill_in "Body", with: "Updated body content"
      end
      click_button "Update Project"
      expect( page ).to have_content( "Project was successfully updated." )
      expect( Project.count ).to eq( 1 )
      expect( Project.find( 1 ).title ).to eq( "Updated title" )
      expect( Project.find( 1 ).body ).to eq( "Updated body content" )
    end

    scenario "should fail with empty title" do
      within( "form" ) do
        fill_in "Title", with: ""
        fill_in "Body", with: "Body content"
      end
      click_button "Update Project"
      expect( page ).to have_content( "Title can't be blank." )
      expect( Project.count ).to eq( 1 )
      expect( Project.find( 1 ).title ).to eq( "Title" )
      expect( Project.find( 1 ).body ).to eq( "Body content" )
    end

    scenario "should fail with empty body" do
      within( "form" ) do
        fill_in "Title", with: "Title"
        fill_in "Body", with: ""
      end
      click_button "Update Project"
      expect( page ).to have_content( "Body can't be blank." )
      expect( Project.count ).to eq( 1 )
      expect( Project.find( 1 ).title ).to eq( "Title" )
      expect( Project.find( 1 ).body ).to eq( "Body content" )
    end
  end

  context "Remove project" do
    let!( :project ) { Project.create( title: "Title", body: "Body content" ) }
    before( :each ) do
      visit projects_path
    end

    scenario "should be successful" do
      click_link "Destroy"
      expect( page ).to have_content( "Project was successfully destroyed." )
      expect( Project.count ).to eq( 0 )
    end
  end
end
