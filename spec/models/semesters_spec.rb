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
      semester = Factory.build(:semester)#, :interns => ['1231231', '1231232', '1231233'])
      semester.internslist.should == "1231231\n1231232\n1231233"
    end
    it 'should split the text on linebreaks' do
      semester = Factory.build(:semester)#, :internslist => "1231231\n1231232\n1231233")
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

  describe '#current' do
    describe 'should be SS between March and September' do
      before(:each) do
        @ws2009 = Semester.create!(:year => 2009, :ws => true  )
        @ss2010 = Semester.create!(:year => 2010, :ws => false )
        @ws2010 = Semester.create!(:year => 2010, :ws => true  )
      end

      it '#1' do
        Date.stubs(:today).returns(Date.parse('13.4.2010'))
        Semester.current.should.should == @ss2010
      end
      it '#2' do
        Date.stubs(:today).returns(Date.parse('13.9.2010'))
        Semester.current.should.should == @ss2010
      end
      it '#3' do
        Date.stubs(:today).returns(Date.parse('01.3.2010'))
        Semester.current.should.should == @ss2010
      end
      it '#4 use the current years WS' do
        Date.stubs(:today).returns(Date.parse('01.10.2010'))
        Semester.current.should.should == @ws2010
      end
      it '#5 use the last years WS' do
        Date.stubs(:today).returns(Date.parse('28.2.2010'))
        Semester.current.should.should == @ws2009
      end
    end

    describe '#create new semester' do
      before(:each) do
      end
      it 'should ' do
        Date.stubs(:today).returns(Date.parse('28.2.2010'))
        tmp=Semester.count
        Semester.current.should
        Semester.count.should == tmp + 1
        Semester.last.year.should == 2009
        Semester.last.ws.should be_true
      end
    end
  end
end

