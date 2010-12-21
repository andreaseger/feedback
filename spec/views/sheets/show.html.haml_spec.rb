require 'spec_helper'

describe "/sheets/show.html.haml" do
  #include Devise::TestHelpers
  before :each do
    assign(:sheet, Factory.stub(:full_sheet))
    @user = Factory.stub(:bob)
    @controller.stubs(:current_user).returns(@user)
  end

  @sheet = Factory.attributes_for(:full_sheet)
  @sheet.each do |key, value|
    it "should show #{key}" do
      render
      if key.to_s =~ /address/
        @rendered.should contain(value[:street])
        @rendered.should contain(value[:city])
        @rendered.should contain(value[:post_code])
        @rendered.should contain(value[:country])
      elsif key.to_s =~ /big_project/
        if value
          @rendered.should contain('Big Project')
        else
          @rendered.should contain('Small Projects')
        end
      elsif key.to_s =~ /flextime/
        if value
          @rendered.should contain('Flextime')
        else
          @rendered.should contain('Fixedtime')
        end
      else
        @rendered.should contain(value.to_s)
      end
    end
  end
end

