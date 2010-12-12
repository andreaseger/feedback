require 'spec_helper'

describe UsersController do
  before(:all) do
    @nds = "foo12345"
    @dn = "cn=#{@nds},ou=3,ou=stud,o=dev-test,c=de"
    @mail = "john.doe@stud.dev-test.de"
    ldif = "dn: #{@dn}
urrzfullname: John Doe
mail: #{@mail}
urrzgivenname: John
cn: #{@nds}
uid: #{@nds}
urrzsurname: Doe"
    @entry = Net::LDAP::Entry.from_single_ldif_string(ldif)
  end
  before(:each) do
    session[:user_info] = @entry
  end

  context '#GET new' do
    it 'should invoke new_with_ldap' do
      User.expects(:new_with_ldap).with(@entry).returns(User.new)
      get :new
    end
  end
  context '#POST create' do
    before(:each) do
      @user = User.new_with_ldap(@entry)
    end
    it 'should create a new user' do
      User.expects(:new_with_ldap).with(@entry).returns(@user)
      post :create, :user => {:matnr => 1231231}
    end
    it 'should save the user' do
      User.stubs(:new_with_ldap).returns(@user)
      @user.expects(:save)
      post :create, :user => {:matnr => 1231231}
    end
    it 'should set the matnr' do
      User.stubs(:new_with_ldap).returns(@user)
      @user.expects(:matnr=).with(1231231)
      @user.stubs(:save).returns(false)
      post :create, :user => {:matnr => 1231231}
    end

    context '#failure' do
      before(:each) do
        User.stubs(:new_with_ldap).returns(@user)
        @user.stubs(:save).returns(false)
      end
      it 'should render the create template' do
        post :create, :user => {:matnr => 1231231}
        response.should render_template('new')
      end

    end
    context '#success' do
      before(:each) do
        User.stubs(:new_with_ldap).returns(@user)
        @user.stubs(:save).returns(true)
      end
      it 'should redirect_to root_url' do
        post :create, :user => {:matnr => 1231231}
        response.should redirect_to root_url
      end
      it 'should set the user in the session' do
        post :create, :user => {:matnr => 1231231}
        session[:user_id].should == @user.id
      end
      it 'should delete the user_info from session' do
        post :create, :user => {:matnr => 1231231}
        session[:user_info].should be_nil
      end

    end
  end
end

