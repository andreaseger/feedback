require 'spec_helper'

describe SessionsController do
  context '#POST create' do
    before(:all) do
      @nds = "asd12345"
      @password = "secret"
      @dn = "cn=#{@nds},ou=1,ou=stud,o=fooo,c=de"
      @entry = stub(:dn => @dn)
      @user = Factory.stub(:amy, :cached_dn => @dn)
    end
    before(:each) do
      @ldap = Ldap.new
      @ldap.stubs(:authenticate_and_fetch).returns(@entry)
      @ldap.stubs(:authenticate).returns(true)
      Ldap.stubs(:new).returns(@ldap)
    end
    it 'should search for a user with the entered nds' do
      User.stubs(:create_with_ldap!).returns(nil)
      User.stubs(:where).returns([])
      User.expects(:where).with(:nds => @nds).returns([])
      post :create, :user => {:nds => @nds}
    end

    context '#user exists in db and has a cached DN(, or will it fetch on the way anyway)' do
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

      context '#success' do
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

      context '#failure' do
        before(:each) do
          @ldap.stubs(:authenticate).returns(false)
        end
        it 'should redirect_to the login form' do
          post :create, :user => {:nds => @nds}
          response.should redirect_to(new_session_url)
        end
      end
    end

    context '#user exists not yet' do
      before(:each) do
        User.stubs(:where).returns([])
      end

      it 'should create ldap instance' do
        User.stubs(:create_with_ldap!).returns(nil)
        Ldap.expects(:new).returns(@ldap)
        post :create, :user => {:nds => @nds}
      end

      it 'should try to fetch the user data and authenticate him' do
        User.stubs(:create_with_ldap!).returns(nil)
        @ldap.expects(:authenticate_and_fetch).with(@nds, @password).returns(@entry)
        post :create, :user => {:nds => @nds, :password => @password}
      end

      context '#successfull user login' do
        before(:each) do
          @ldap.stubs(:authenticate_and_fetch).returns(@entry)
          #@ldap.stubs(:authenticate).returns(true)
        end
        it 'should create a new user' do
          User.expects(:create_with_ldap!).with(@entry)
          post :create, :user => {:nds => @nds}
        end

        context '#successfull user creation' do
          it 'should redirect_to root_url' do
            User.stubs(:create_with_ldap!).returns(@user)
            post :create, :user => {:nds => @nds}
            response.should redirect_to(root_url)
          end

          it 'should save the new user in the session' do
            User.stubs(:create_with_ldap!).returns(@user)
            post :create, :user => {:nds => @nds}
            session[:user_id].should == @user.id
          end
        end
        context '#user creation not successfull' do
          it 'should redirect_to new_user_url' do
            User.stubs(:create_with_ldap!).returns(nil)
            post :create, :user => {:nds => @nds}
            response.should redirect_to(new_session_url)
          end

          it 'should save the data to the session' do
            #@ldap.stubs(:fetchData).returns(@entry)
            User.stubs(:create_with_ldap!).returns(nil)
            post :create, :user => {:nds => @nds}
            session[:user_info].should == @entry
          end
        end
      end
      context '#failure' do
        before(:each) do
          @ldap.stubs(:authenticate_and_fetch).returns(nil)
        end
        it 'should redirect_to the login form' do
          post :create, :user => {:nds => @nds}
          response.should redirect_to(new_session_url)
        end
      end
    end
  end

  context '#destroy' do
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

