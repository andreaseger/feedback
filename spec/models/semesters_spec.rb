require 'spec_helper'

describe Semester do
  describe '#validations' do
    %w(year ws).each do |attrib|
      it "##{attrib} should be present" do
        semester = Factory.build(:ws2010, attrib => nil)
        semester.should_not be_valid
      end
    end
  end

  describe '#internslist' do
    it 'should return the interns one by one' do
      semester = Factory.build(:semester, :interns => ['1231231', '1231232', '1231233'])
      semester.internslist.should == "1231231\n1231232\n1231233"
    end
    it 'should split the text on linebreaks' do
      semester = Factory.build(:semester, :internslist => "1231231\n1231232\n1231233")
      semester.interns.should == ['1231231', '1231232', '1231233']
    end
  end
  describe '#text' do
    it 'should return SS2010' do
      semester = Factory.build(:semester, :year => 2010, :ws => false)
      semester.text.should == "SS2010"
    end
    it 'should return WS2010/11' do
      semester = Factory.build(:semester, :year => 2010, :ws => true)
      semester.text.should == "WS2010/11"
    end
  end
  describe '#long_text' do
    it 'should return Sommersemester 2010' do
      semester = Factory.build(:semester, :year => 2010, :ws => false)
      semester.long_text.should == "Sommersemester 2010"
    end
    it 'should return Wintersemester 2010/11' do
      semester = Factory.build(:semester, :year => 2010, :ws => true)
      semester.long_text.should == "Wintersemester 2010/11"
    end
  end
end

