require 'spec_helper'

describe Admin::UsersController do

  before (:each) do
    @admin = Factory.stub(:admin)
    @controller.stubs(:authenticate_user!).returns(true)
    @controller.stubs(:current_user).returns(@admin)
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
    before(:each) do
      @u = Factory.stub(:amy)
      User.stubs(:find).returns(@u)
    end
    it 'should remove empty roles' do
      @u.expects(:update_attributes).with({'roles'=>['admin', 'student', 'intern']})
      put :update, :id => @u.id, :user => { 'roles'=>["", "admin", "", "student", "", "intern", ""]}
    end
    it "redirects to the user admin page" do
      put :update, :id => @u.id, :user => {'email' => "foo@bar.com"}
      response.should redirect_to(admin_users_path)
    end
  end
  describe 'POST edit_multiple' do
    before(:each) do
      @u = Factory.stub(:amy)
      @uu = Factory.stub(:bob)
    end
    it 'should render the edit_multiple page for more than one user id' do
      User.stubs(:find).returns([@u, @uu])
      post :edit_multiple, :user_ids => [@u.id, @uu.id]
      response.should render_template('admin/users/edit_multiple')
    end
    it 'should render edit if only one user_id' do
      User.stubs(:find).returns([@u])
      post :edit_multiple, :user_ids => [@u.id]
      response.should render_template('admin/users/edit')
    end
  end

  describe 'PUT update_multiple' do
    before(:each) do
      @u = Factory.stub(:amy)
      @uu = Factory.stub(:bob)
      User.stubs(:find).returns([@u, @uu])
    end
    it 'redirects to the user admin page' do
      put :update_multiple, :user_ids => [@u.id, @uu.id], :user => {'roles' => ["admin"]}
      response.should redirect_to(admin_users_path)
    end
    it 'should change the attribute of all users' do
      @u.expects(:update_attributes).with({'roles'=>['admin']}).returns(true)
      @uu.expects(:update_attributes).with({'roles'=>['admin']}).returns(true)
      put :update_multiple, :user_ids => [@u.id, @uu.id], :user => {'roles' => ["admin"]}
    end
    it 'should render the edit_multiple page if something goes wrong' do
      put :update_multiple, :user_ids => [@u.id, @uu.id], :user => {'roles' => ["intern"]}
      response.should render_template('admin/users/edit_multiple')
    end
  end
end

