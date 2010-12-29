require 'spec_helper'

describe Address do
  context '#validations' do
    before(:each) do
      sheet = Factory(:valid_sheet)
    end
    Factory.attributes_for(:valid_address).keys.each do |attrib|
      it "#{attrib} has to be present" do
        address = Factory.build(:valid_address, attrib => nil)
        address.should_not be_valid
      end
    end
  end
end

