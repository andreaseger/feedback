require 'spec_helper'

describe Sheet do
  describe '#validations' do
    %w(reachability accessibility working_atmosphere satisfaction_with_support stress_factor apartment_market satisfaction_with_internship independent_work reference_to_the_study learning_effect required_previous_knowledge).each do |attrib|
      describe "##{attrib}" do
        it "should be invalid if greater than 4" do
          sheet = Factory.build(:sheet, attrib => 5)
          sheet.should_not be_valid
        end
        it "should be invalid if less than 1" do
          sheet = Factory.build(:sheet, attrib => -2)
          sheet.should_not be_valid
        end
        it "should be valid if 3" do
          sheet = Factory.build(:sheet, attrib => 3)
          sheet.should be_valid
        end
      end
    end
  end
end

