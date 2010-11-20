require 'spec_helper'

describe Sheet do
  describe '#validations' do
    %w(reachability accessibility working_atmosphere satisfaction_with_support stress_factor apartment_market satisfaction_with_internship independent_work reference_to_the_study learning_effect required_previous_knowledge).each do |attrib|
      describe "##{attrib}" do
        it "should be invalid if greater than 4" do
          sheet = Factory.build(:valid_sheet, attrib => 5)
          sheet.should_not be_valid
        end
        it "should be invalid if less than 1" do
          sheet = Factory.build(:valid_sheet, attrib => -2)
          sheet.should_not be_valid
        end
        it "should be valid if 3" do
          sheet = Factory.build(:valid_sheet, attrib => 3)
          sheet.should be_valid
        end
      end
    end
    Factory.attributes_for(:valid_sheet).keys.each do |attrib|
      it "#{attrib} has to be present" do
        sheet = Factory.build(:valid_sheet, attrib => nil)
        sheet.should_not be_valid
      end
    end
  end

  describe '#required_languages' do
    it 'should split strings with a dot correctly' do
      sheet = Factory(:valid_sheet, :required_languages => "foo. lorem")
      sheet.speeches.should == ["foo", "lorem"]
    end
    it 'should split strings with a comma correctly' do
      sheet = Factory(:valid_sheet, :required_languages => "foo, lorem")
      sheet.speeches.should == ["foo", "lorem"]
    end
    it 'should split strings with a space correctly' do
      sheet = Factory(:valid_sheet, :required_languages => "foo lorem")
      sheet.speeches.should == ["foo", "lorem"]
    end
    it 'should split the input on space, komma' do
      sheet = Factory.build(:valid_sheet, :required_languages => "greek spanish, english,latin")
      sheet.speeches.should == ["greek", "spanish", "english", "latin"]
    end
    it 'should give a string of all assigned speeches' do
      sheet = Factory(:valid_sheet, :required_languages => nil, :speeches=>["foo", "bar", "baz", "lorem"])
      sheet.required_languages.should == "foo bar baz lorem"
    end
  end
end

