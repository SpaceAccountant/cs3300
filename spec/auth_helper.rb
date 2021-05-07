require 'spec_helper'

module AuthHelper
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryBot.create( :user )
  end
end
