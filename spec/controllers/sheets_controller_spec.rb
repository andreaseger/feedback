require 'spec_helper'

describe SheetsController do
  context '#logged in' do
    before(:each) do
      @user = Factory.stub(:bob)
      @controller.stubs(:authenticate!).returns(true)
      @controller.stubs(:current_user).returns(@user)
    end
    context '#GET new' do
      it 'should create new Address Objects' do
        pending "kA wie ich das testen soll, schaff es nicht @sheet richtig zu mocken"
        # ich kann weder testen ob @sheet dann 2 Adressen hat noch
        # kann ich testen ob @sheet die befehle build_application_address ... empfängt
        s = Sheet.new()
        Sheet.stubs(:new).returns(s)
        Sheet.any_instance.expects(:build_application_address)
        #Sheet.any_instance.expects(:job_site_address=)
        #Sheet.any_instance.expects(:build_job_site_address)
        get :new
      end
    end
    context '#POST create' do
      it 'should set the user to current_user' do
        pending "foo, bekomm keinen test hin der das überprüft"
        controller.stubs(:current_user).returns(@user)
        #TODO
        sheet = Factory.attributes_for(:valid_sheet)
        post :create, :sheet => sheet
        ap Sheet.all.entries
        Sheet.last.user.should == @user
      end
    end
  end

  context '#not logged in' do
    before(:each) do
      controller.stubs(:user_signed_in?).returns(false)
    end
    # perhaps i should add tests for the other actions, but its always the same before filter
    it 'should redirect me to the login site' do
      get :index
      response.should redirect_to(new_session_url)
    end
  end
end

