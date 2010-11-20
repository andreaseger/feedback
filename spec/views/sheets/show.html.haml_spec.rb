require 'spec_helper'

describe "/sheets/show.html.haml" do

  before do
    assign(:sheet, Factory.stub(:full_sheet))
  end

  @sheet = Factory.attributes_for(:full_sheet)
  @sheet.each do |key, value|
    it "should show #{key}" do
      render
      if key =~ /address/
        rendered.should contain(value[:street])
        rendered.should contain(value[:city])
        rendered.should contain(value[:post_code])
        rendered.should contain(value[:country])
      else
        rendered.should contain(value.to_s)
      end
    end
  end
end

