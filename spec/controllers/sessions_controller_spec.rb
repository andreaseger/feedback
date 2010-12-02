require 'spec_helper'

describe SessionsController do
  describe '#POST create' do
    before(:all) do
      @nds = "asd12345"
      @password = "secret"
      @dn = "cn=#{@nds},ou=1,ou=stud,o=fooo,c=de"
      @entry = stub(:dn => @dn)
      @user = Factory.stub(:amy, :cached_dn => @dn)
    end
    before(:each) do
      @ldap = Ldap.new
      @ldap.stubs(:fetchData).returns(@entry)
      @ldap.stubs(:authenticate).returns(true)
      Ldap.stubs(:new).returns(@ldap)
    end
    it 'should search for a user with the entered nds' do
      User.expects(:where).with(:nds => @nds).returns([])
      post :create, :user => {:nds => @nds}
    end

    describe '#user exists in db and has a cached DN(, or will it fetch on the way anyway)' do
      before(:each) do
        User.stubs(:where).returns([@user])
      end

      it 'should create ldap instance' do
        Ldap.expects(:new).returns(@ldap)
        post :create, :user => {:nds => @nds}
      end

      it 'should call authenticate with dn and password' do
        @ldap.expects(:authenticate).with(@dn, @password)
        post :create, :user => {:nds => @nds, :password => @password}
      end

      describe '#success' do
        before(:all) do
          @ldap.stubs(:authenticate).returns(true)
        end
        it 'should redirect_to root_url' do
          post :create, :user => {:nds => @nds}
          response.should redirect_to(root_url)
        end
        it 'should save the user in the session' do
          post :create, :user => {:nds => @nds}
          session[:user_id].should == @user.id
        end
      end

      describe '#failure' do
        before(:each) do
          @ldap.stubs(:authenticate).returns(false)
        end
        it 'should redirect_to the login form' do
          post :create, :user => {:nds => @nds}
          response.should redirect_to(new_session_url)
        end
      end
    end

    describe '#user exists not yet' do
      before(:each) do
        User.stubs(:where).returns([])
      end

      it 'should create ldap instance' do
        Ldap.expects(:new).returns(@ldap)
        post :create, :user => {:nds => @nds}
      end

      it 'should try to fetch the user data' do
        @ldap.expects(:fetchData).with(@nds).returns(@entry)
        post :create, :user => {:nds => @nds}
      end

      it 'should authenticate the user' do
        @ldap.expects(:authenticate).with(@dn, @password)
        post :create, :user => {:nds => @nds, :password => @password}
      end

      describe '#success' do
        before(:each) do
          @ldap.stubs(:authenticate).returns(true)
        end
        it 'should create a new user' do
          User.expects(:create_with_ldap!).with(@entry)
          post :create, :user => {:nds => @nds}
        end

        it 'should redirect_to root_url' do
          User.stubs(:create_with_ldap!).returns(@user)   #not really true but its just should pass the if-clouse
          post :create, :user => {:nds => @nds}
          response.should redirect_to(root_url)
        end

        it 'should redirect_to root_url' do
          User.stubs(:create_with_ldap!).returns(nil)
          post :create, :user => {:nds => @nds}
          response.should redirect_to(new_session_url)
        end

        it 'should save the new user in the session' do
          User.stubs(:create_with_ldap!).returns(@user)
          post :create, :user => {:nds => @nds}
          session[:user_id].should == @user.id
        end
      end
      describe '#failure' do
        before(:each) do
          @ldap.stubs(:authenticate).returns(false)
        end
        it 'should redirect_to the login form' do
          post :create, :user => {:nds => @nds}
          response.should redirect_to(new_session_url)
        end
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      controller.stubs(:user_signed_in?).returns(true)
      session[:user_id] = "foo"
    end
    it 'should set the session to nil' do
      delete :destroy, :id => 123
      session[:user_id].should == nil
    end
  end

end

