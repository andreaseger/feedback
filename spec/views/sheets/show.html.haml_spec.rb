require 'spec_helper'

describe "/sheets/show.html.haml" do

  before do
    assign(:sheet, Factory.stub(:full_sheet))
  end

  @sheet = Factory.attributes_for(:full_sheet)
  @sheet.each do |key, value|
    it "should show #{key}" do
      render
      rendered.should contain(value.to_s)
    end
  end
end

