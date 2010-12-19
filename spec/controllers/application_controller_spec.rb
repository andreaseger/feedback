require 'spec_helper'

describe ApplicationController do
  before(:each) do
    @user = Factory(:bob)
  end
  describe '#current_user' do
    describe '@current_user = nil' do
      before(:each) do
        @current_user = nil
      end
      it 'should search for the user with the session' do
        session[:user_id] = @user.id
        User.expects(:find).with(@user.id)
        controller.instance_eval{current_user}
      end
      it 'should not search if there is no user saved in the session' do
        session[:user_id] = nil
        User.expects(:find).never
        controller.instance_eval{current_user}
      end
      it 'should save the user in a instance variable' do
        session[:user_id] = @user.id
        User.stubs(:find).with(@user.id).returns(@user)
        controller.instance_eval{current_user}
        controller.instance_eval{ @current_user }.should == @user
      end
    end
    describe '@current_user already set' do
      before(:each) do
        controller.instance_eval{@current_user = "foo"}
        # i cant access @user in the scope of the controller so I just make @current_user return true
      end
      it 'should not search again for the user' do
        session[:user_id] = @user.id
        User.expects(:find).never
        controller.instance_eval{current_user}
      end
      it 'should return nil if the session is set' do
        session[:user_id] = nil
        controller.instance_eval{current_user}.should be_nil
      end
    end
  end

  describe '#user_signed_in?' do
    it 'should be true if current_user is set' do
      controller.stubs(:current_user).returns(@user)
      controller.instance_eval{user_signed_in?}.should be_true
    end
    it 'should be true if current_user is set' do
      controller.stubs(:current_user).returns(nil)
      controller.instance_eval{user_signed_in?}.should be_false
    end
    it 'should still be false if @current_user is set while the session is empty' do
      controller.instance_eval{@current_user = "foo"}
      session[:user_id] = nil
      controller.instance_eval{user_signed_in?}.should be_false
    end
  end

  describe '#current_semester' do
    describe '@current_semester already set' do
      before(:each) do
        controller.instance_eval{@current_semester = "foo"}
      end
      it 'should not search again for the user' do
        Semester.expects(:current).never
        controller.instance_eval{current_semester}
      end
    end
  end
end

