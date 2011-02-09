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

  context "GET index" do
    #it "assigns all users as @users" do
    #  User.stubs(:all).returns([mock_user])
    #  get :index
    #  assigns(:users).should eq([mock_user])
    #end
  end

  context 'PUT update' do
    before(:each) do
      @u = Factory.stub(:amy)
      User.stubs(:find).returns(@u)
    end
    it 'should remove empty roles' do
      @u.expects(:update_attributes).with({'roles'=>['admin', 'student', 'intern']})
      put :update, :id => @u.id, :user => { 'roles'=>["", "admin", "", "student", "", "intern", ""]}
    end
    it "redirects to the user admin page" do
      @u.stubs(:update_attributes).returns(true)
      put :update, :id => @u.id, :user => {'email' => "foo@bar.com"}
      response.should redirect_to(admin_users_path)
    end
  end
  context 'POST edit_multiple' do
    before(:each) do
      @u = Factory.stub(:amy)
      @uu = Factory.stub(:bob)
    end
    it 'should redirect to all users if none was selected' do
      User.stubs(:find).returns([])
      post :edit_multiple, :user_ids => [@u.id]
      response.should redirect_to(admin_users_path)
    end
    it 'should render edit if only one user_id' do
      User.stubs(:find).returns([@u])
      post :edit_multiple, :user_ids => [@u.id]
      response.should render_template('admin/users/edit')
    end
    it 'should render the edit_multiple page for more than one user id' do
      User.stubs(:find).returns([@u, @uu])
      post :edit_multiple, :user_ids => [@u.id, @uu.id]
      response.should render_template('admin/users/edit_multiple')
    end
  end

  context 'PUT update_multiple' do
    before(:each) do
      @u = Factory.stub(:amy)
      @uu = Factory.stub(:bob)
      User.stubs(:find).returns([@u, @uu])
    end
    context 'when all goes well' do
      before :each do
        @u.stubs(:update_attributes).returns(true)
        @uu.stubs(:update_attributes).returns(true)
      end
      it 'redirects to the user admin page' do
        @u.stubs(:update_attributes).returns(true)
        @uu.stubs(:update_attributes).returns(true)
        put :update_multiple, :user_ids => [@u.id, @uu.id], :user => {'roles' => ["admin"]}
        response.should redirect_to(admin_users_path)
      end
      it 'should change the attribute of all users' do
        @u.expects(:update_attributes).with({'roles'=>['admin']}).returns(true)
        @uu.expects(:update_attributes).with({'roles'=>['admin']}).returns(true)
        put :update_multiple, :user_ids => [@u.id, @uu.id], :user => {'roles' => ["admin"]}
      end
    end
    context 'when something goes wrong' do
      before :each do
        @u.stubs(:update_attributes).returns(false)
        @uu.stubs(:update_attributes).returns(false)
      end
      it 'should render the edit_multiple page' do
        put :update_multiple, :user_ids => [@u.id, @uu.id], :user => {'roles' => ["intern"]}
        response.should render_template('admin/users/edit_multiple')
      end
    end
  end
end

