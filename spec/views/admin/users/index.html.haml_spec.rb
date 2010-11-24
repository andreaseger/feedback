require 'spec_helper'

describe "/admin/users/index.html.haml" do
  include Devise::TestHelpers
  before do
    assign(:users, [Factory.stub(:bob), Factory.stub(:amy)])
    @admin = Factory(:admin)
    sign_in @admin
  end

  it 'should show some users' do
    render
    rendered.should contain("Bob")
    rendered.should contain("Amy")
  end
end

