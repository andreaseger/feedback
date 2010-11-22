require 'spec_helper'

describe Admin::UsersController do
  include Devise::TestHelpers

  before do
    @admin = Factory(:admin)
    sign_in @admin
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all users as @users" do
      User.stub(:all) { [mock_user] }
      get :index
      assigns(:users).should eq([mock_user])
    end
  end
end

