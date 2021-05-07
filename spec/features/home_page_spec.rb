require 'rails_helper'

RSpec.feature "HomePages", type: :feature do
  # TODO: Update viewing roles when login is complete.
  context "Viewing projects" do
    let!( :project ) { Project.create( title: "Test title", body: "Test body content" ) }
    before( :each ) do
      visit root_path
    end

    scenario "as the visitor" do
      expect( page ).to have_text( "Projects" )
      expect( page ).to have_text( "Title" )
      expect( page ).to have_text( "Test title" )
      expect( page ).to have_text( "Test body content" )
      expect( page ).to have_link( "Show" )
    end

    scenario "as the student" do
      expect( page ).to have_text( "Projects" )
      expect( page ).to have_text( "Title" )
      expect( page ).to have_text( "Test title" )
      expect( page ).to have_text( "Test body content" )
      expect( page ).to have_link( "Show" )
      expect( page ).to have_link( "Edit" )
      expect( page ).to have_link( "Destroy" )
      expect( page ).to have_link( "New Project" )
    end
  end
end
