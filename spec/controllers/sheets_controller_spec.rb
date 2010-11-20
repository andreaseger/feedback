require 'spec_helper'

describe SheetsController do
  include Devise::TestHelpers
  describe '#logged in' do
    before do
      @user = Factory(:bob)
      sign_in :user, @user
    end
  end
  describe '#not logged in' do
    before(:each) do
      sign_out :user
    end
    # perhaps i should add tests for the other actions, but its always the same before filter
    it 'should redirect me to the login site' do
      get :index
      response.should redirect_to(new_user_session_url)
    end
  end
end

