require 'spec_helper'

describe "/admin/users/index.html.haml" do
  include Devise::TestHelpers
  before do
    assign(:users, [Factory.stub(:bob), Factory.stub(:amy), Factory.stub(:intern), Factory.stub(:prof)])
    @admin = Factory(:admin)
    sign_in @admin
  end

  it 'should show some users' do
    render
    rendered.should contain("bob@foo.com")
    rendered.should contain("amy@foo.com")
    rendered.should contain("intern@foo.com")
    rendered.should contain("prof@foo.com")
  end
end

