require 'spec_helper'

describe Admin::UsersController do
  include Devise::TestHelpers

  before (:each) do
    @admin = Factory(:admin)
    sign_in :user, @admin
  end

  def mock_user
    @mock_user ||= Factory.stub(:bob)
  end

  describe "GET index" do
    it "assigns all users as @users" do
      User.stubs(:all).returns([mock_user])
      get :index
      assigns(:users).should eq([mock_user])
    end
  end

  describe 'PUT update' do
    # nicht besonders schoen da mit datenbankzugriff, liegt evtl an Mongoid???
    before(:each) do
      @u = Factory(:amy)
    end
    it 'should remove empty roles' do
      put :update, :id => @u.id, :user => { 'roles'=>["", "admin", "", "student", "", "intern", ""]}
      User.last.roles.should == ["admin", "student", "intern"]
    end
    it "redirects to the user admin page" do
      put :update, :id => @u.id, :user => {'email' => "foo@bar.com"}
      response.should redirect_to(admin_users_path)
    end
  end
  describe 'POST edit_multiple' do
    before(:each) do
      @u = Factory(:amy)
      @uu = Factory(:bob)
    end
    it 'should render the edit_multiple page for more than one user id' do
      post :edit_multiple, :user_ids => [@u.id, @uu.id]
      response.should render_template('admin/users/edit_multiple')
    end
    it 'should render edit if only one user_id' do
      post :edit_multiple, :user_ids => [@u.id]
      response.should render_template('admin/users/edit')
    end
  end

  describe 'PUT update_multiple' do
    before(:each) do
      @u  = Factory(:amy)
      @uu = Factory(:bob)
    end
    it 'redirects to the user admin page' do
      put :update_multiple, :user_ids => [@u.id, @uu.id], :user => {'roles' => ["admin"]}
      response.should redirect_to(admin_users_path)
    end
    it 'should change the attribute of all users' do
      put :update_multiple, :user_ids => [@u.id, @uu.id], :user => {'roles' => ["admin"]}
      User.find(@u.id).roles.should == ["admin"]
      User.find(@uu.id).roles.should == ["admin"]
    end
    it 'should render the edit_multiple page if something goes wrong' do
      put :update_multiple, :user_ids => [@u.id, @uu.id], :user => {'roles' => ["intern"]}
      response.should render_template('admin/users/edit_multiple')
    end
  end
end

