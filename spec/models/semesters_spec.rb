require 'spec_helper'

describe Semester do
  context '#validations' do
    %w(year ws).each do |attrib|
      it "##{attrib} should be present" do
        semester = Factory.build(:semester, attrib => nil)
        semester.should_not be_valid
      end
    end

    it 'should check that [year,ws] is unique' do
      Semester.delete_all
      Factory(:semester, :year => 2000, :ws =>true)
      semester = Factory.build(:semester, :year => 2000, :ws =>true)
      semester2 = Factory.build(:semester, :year => 2000, :ws =>false)
      semester.should_not be_valid
      semester2.should be_valid
    end
  end

  context '#matrlist' do
    before(:each) do
      @u1=Factory(:student, :matnr => '3333333')
      @u2=Factory(:bob, :matnr => '5555555')
    end
    it 'should return the interns by there matnr' do
      semester = Factory.build(:semester, :interns => [@u1, @u2])
      semester.matrlist.should == "3333333\n5555555"
    end
    it 'should split the text on linebreaks' do
      semester = Factory.build(:semester, :matrlist => "3333333\r\n5555555")
      semester.interns.should == [@u1, @u2]
    end
    it 'should remove no longer set interns' do
      semester = Factory.build(:semester, :interns => [@u1, @u2])
      semester.matrlist = "3333333"
      semester.interns.should == [@u1]
    end
    it 'should add new interns' do
      semester = Factory.build(:semester, :interns => [@u1])
      semester.matrlist = "3333333\n5555555"
      semester.interns.should == [@u1, @u2]
    end
    it 'should update the interns via update_attributes' do
      semester = Factory(:semester, :interns => [@u1])
      semester.update_attributes(:matrlist => "3333333\n5555555")
      Semester.last.interns.should == [@u1, @u2]
    end
    it 'should save unknown matnumbers' do
      semester = Factory(:semester, :matrlist => "3333333\r\n7777777")
      Semester.stubs(:current).returns(semester)
      Semester.current.unknown.should == ["7777777"]
    end
    it 'should assign the user also if the user gets created after the semester' do
      semester = Factory(:current, :matrlist => "3333333\r\n7777777")
      u3=Factory(:student, :matnr => '7777777')
      Semester.current.interns.should == [@u1, u3]
    end
    it 'should show both found interns and unknown matrikelnumbers' do
      semester = Factory(:current, :interns => [@u1], :unknown => [4444444])
      semester.matrlist.should == "3333333\n4444444"
    end
  end

  context '#text' do
    it 'should return SS2010' do
      semester = Factory.build(:semester, :year => 2010, :ws => false)
      semester.text.should == "SS2010"
    end
    it 'should return WS2010/11' do
      semester = Factory.build(:semester, :year => 2010, :ws => true)
      semester.text.should == "WS2010/11"
    end
  end
  context '#long_text' do
    it 'should return Sommersemester 2010' do
      semester = Factory.build(:semester, :year => 2010, :ws => false)
      semester.long_text.should == "Sommersemester 2010"
    end
    it 'should return Wintersemester 2010/11' do
      semester = Factory.build(:semester, :year => 2010, :ws => true)
      semester.long_text.should == "Wintersemester 2010/11"
    end
  end

  context '#current' do
    context 'should be SS between March and September' do
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

    context '#create new semester' do
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

