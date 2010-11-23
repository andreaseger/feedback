require 'spec_helper'

describe Admin::UsersController do
  include Devise::TestHelpers

  before (:each) do
    @admin = Factory(:admin)
    sign_in :user, @admin
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

  describe 'PUT update' do
    it 'should remove empty roles' do
      # nicht besonders schoen da mit datenbankzugriff
      u = Factory(:amy)
      put :update, :id => u.id, :user => { 'roles'=>["", "admin", "", "student", "", "intern", "", "prof"]}
      User.last.roles.should == ["admin", "student", "intern", "prof"]
    end
    it "redirects to the user admin page" do
      pending "warum auch immer ist hier der user nicht eingeloggt"
      User.stub(:find) { mock_user(:update_attributes => true) }
      put :update, :id => "9"
      response.should redirect_to(admin_users_path)
    end
  end

end

