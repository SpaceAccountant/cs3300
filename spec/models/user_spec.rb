require "rails_helper"

RSpec.describe User, type: :model do
  context "validation tests" do
    it "ensures users can be constructed" do
      expect { User.new( { email: "a@b.com", password: "123456", password_confirmation: "123456" } ) }.not_to raise_exception
    end

    it "ensures the user email is present" do
      user = User.new( encrypted_password: "123456" )
      expect( user.valid? ).to eq( false )
    end

    it "ensures the user encrypted password is present" do
      user = User.new( email: "a@b.com" )
      expect( user.valid? ).to eq( false )
    end

    it "ensures users can be saved" do
      user = User.new( { email: "a@b.com", password: "123456", password_confirmation: "123456" } )
      expect( user.save ).to eq( true )
      expect( User.count ).to eq( 1 )
    end

    it "ensures users need a 6 character password to be saved" do
      user = User.new( { email: "a@b.com", password: "12345", password_confirmation: "12345" } )
      expect( user.save ).to eq( false )
      expect( User.count ).to eq( 0 )
    end

    it "ensures saved users can be found by id" do
      user = User.new( { email: "a@b.com", password: "123456", password_confirmation: "123456" } )
      user.save
      expect( User.find( user.id ) ).to eq( user )
    end

    it "ensures the user created at time is present on saved users" do
      user = User.new( { email: "a@b.com", password: "123456", password_confirmation: "123456" } )
      user.save
      expect( User.find( user.id ).created_at ).not_to eq( nil )
    end

    it "ensures saved users can be removed" do
      user = User.new( { email: "a@b.com", password: "123456", password_confirmation: "123456" } )
      user.save
      user.destroy
      expect( User.count ).to eq( 0 )
    end
  end

  context "scope tests" do
  end
end
