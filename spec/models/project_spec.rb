require "rails_helper"

RSpec.describe Project, type: :model do
  context "validation tests" do
    it "ensures projects can be constructed" do
      expect { Project.new }.not_to raise_exception
      expect { Project.new( title: "Title" ) }.not_to raise_exception
      expect { Project.new( body: "Body content" ) }.not_to raise_exception
      expect { Project.new( title: "Title", body: "Body content" ) }.not_to raise_exception
    end

    it "ensures the project title is present" do
      project = Project.new( body: "Body content" )
      expect( project.valid? ).to eq( false )
    end

    it "ensures the project body is present" do
      project = Project.new( title: "Title" )
      expect( project.valid? ).to eq( false )
    end

    it "ensures projects can be saved" do
      project = Project.new( title: "Title", body: "Body content" )
      expect( project.save ).to eq( true )
      expect( Project.count ).to eq( 1 )
    end

    it "ensures saved projects can be found by id" do
      project = Project.new( title: "Title", body: "Body content" )
      project.save
      expect( Project.find( project.id ) ).to eq( project )
    end

    it "ensures the project created at time is present on saved projects" do
      project = Project.new( title: "Title", body: "Body content" )
      project.save
      expect( Project.find( project.id ).created_at ).not_to eq( nil )
    end

    it "ensures the project updated at time is present on saved projects" do
      project = Project.new( title: "Title", body: "Body content" )
      project.save
      expect( Project.find( project.id ).updated_at ).not_to eq( nil )
    end

    it "ensures saved projects can be removed" do
      project = Project.new( title: "Title", body: "Body content" )
      project.save
      project.destroy
      expect( Project.count ).to eq( 0 )
    end
  end

  context "scope tests" do
    let( :params ) { { title: "Title", body: "Body content" } }
    before( :each ) do
      Project.create( params )
      Project.create( params )
      Project.create( params )
    end

    it "should return all projects" do
      expect( Project.count ).to eq( 3 )
    end
  end
end
