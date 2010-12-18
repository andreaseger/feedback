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
    describe 'should be SS between March and September' do
      before(:each) do
        @ws2009 = Semester.create!(:year => 2009, :ws => true  , :interns => ['123'])
        @ss2010 = Semester.create!(:year => 2010, :ws => false , :interns => ['123'])
        @ws2010 = Semester.create!(:year => 2010, :ws => true  , :interns => ['123'])
      end

      it '#1' do
        Date.stubs(:today).returns(Date.parse('13.4.2010'))
        controller.instance_eval{current_semester}.should == @ss2010
      end
      it '#2' do
        Date.stubs(:today).returns(Date.parse('13.9.2010'))
        controller.instance_eval{current_semester}.should == @ss2010
      end
      it '#3' do
        Date.stubs(:today).returns(Date.parse('01.3.2010'))
        controller.instance_eval{current_semester}.should == @ss2010
      end
      it '#4 use the current years WS' do
        Date.stubs(:today).returns(Date.parse('01.10.2010'))
        controller.instance_eval{current_semester}.should == @ws2010
      end
      it '#5 use the last years WS' do
        Date.stubs(:today).returns(Date.parse('28.2.2010'))
        controller.instance_eval{current_semester}.should == @ws2009
      end
    end
    describe '@current_semester already set' do
      before(:each) do
        controller.instance_eval{@current_semester = "foo"}
      end
      it 'should not search again for the user' do
        Semester.expects(:where).never
        controller.instance_eval{current_semester}
      end
    end
    describe '#create new semester' do
      before(:each) do

      end
      it 'should ' do
        Date.stubs(:today).returns(Date.parse('28.2.2010'))
        tmp=Semester.count
        controller.instance_eval{current_semester}
        Semester.count.should == tmp + 1
        Semester.last.year.should == 2009
        Semester.last.ws.should be_true
      end
    end
  end
end

