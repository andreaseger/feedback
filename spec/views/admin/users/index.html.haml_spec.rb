require 'spec_helper'

describe "/admin/users/index.html.haml" do
  before :each do
    assign(:users, [Factory.stub(:bob), Factory.stub(:amy)])
    @admin = Factory.stub(:admin)
    @view.stubs(:current_user).returns(@admin)
  end

  #it 'should show some users' do
  #  render
  #  rendered.should contain("Bob")
  #  rendered.should contain("Amy")
  #end
end

