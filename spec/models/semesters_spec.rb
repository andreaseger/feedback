require 'spec_helper'

describe Semester do
  describe '#validations' do
    %w(text sort interns).each do |attrib|
      it "##{attrib} should be present" do
        semester = Factory.build(:ws2010, attrib => nil)
        semester.should_not be_valid
      end
    end
  end

  describe '#internslist' do
    it 'should return the interns one by one' do
      semester = Factory.build(:ws2010, :interns => ['1231231', '1231232', '1231233'])
      semester.internslist.should == "1231231\n1231232\n1231233"
    end
    it 'should split the text on linebreaks' do
      semester = Factory.build(:ws2010, :interns => nil, :internslist => "1231231\n1231232\n1231233")
      semester.interns.should == ['1231231', '1231232', '1231233']
    end
  end
end

