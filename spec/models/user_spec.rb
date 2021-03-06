require 'spec_helper'

describe User do
  context '#validations' do
    it 'should check that nds is unique' do
      Factory(:bob, :nds => "abc12345")
      user = Factory.build(:amy, :nds => "abc12345")
      user.should_not be_valid
    end

    it 'should check that matnr is unique' do
      Factory(:bob, :matnr => "1111111")
      user = Factory.build(:amy, :matnr => "1111111")
      user.should_not be_valid
    end

    %w(nds email name).each do |attrib|
      it "##{attrib} should be present" do
        user = Factory.build(:bob, attrib => nil)
        user.should_not be_valid
      end
    end

    it 'needs a matnr if user is a student' do
      user = Factory.build(:student, :matnr => nil)
      user.should_not be_valid
    end
    it 'should not need a matnr if its a admin or external' do
      user = Factory.build(:extern, :matnr => nil)
      user.should be_valid
      user = Factory.build(:admin, :matnr => nil)
      user.should be_valid
    end

    context '#roles' do
      # removed
      #it 'should not allow interns who are no students' do
      #  user = Factory.build(:bob, :roles => ["intern"])
      #  user.should_not be_valid
      #end
      it 'should not allow users to be student and prof at the same time' do
        user = Factory.build(:bob, :roles => ["student", "extern"])
        user.should_not be_valid
      end
      it 'should check if all the assigned roles are defined' do
        user = Factory.build(:bob, :roles => ["super"])
        user.should_not be_valid
      end
    end
  end

  context '#role?' do
    before(:each) do
      @admin = Factory.build(:admin)
      @student = Factory.build(:student)
      @extern = Factory.build(:extern)
      @intern = Factory(:student)
      semester = Factory(:semester, :interns => [@intern])
      Semester.stubs(:current).returns(semester)
    end

    context 'should be true for the right role' do
      it '#admin' do
        @admin.role?(:admin).should be_true
        @admin.role?(:student).should be_false
        @admin.role?(:extern).should be_false
        @admin.role?(:intern).should be_false
      end
      it '#student' do
        @student.role?(:admin).should be_false
        @student.role?(:student).should be_true
        @student.role?(:extern).should be_false
        @student.role?(:intern).should be_false
      end
      it '#extern' do
        @extern.role?(:admin).should be_false
        @extern.role?(:student).should be_false
        @extern.role?(:extern).should be_true
        @extern.role?(:intern).should be_false
      end
      it '#intern' do
        @intern.role?(:admin).should be_false
        @intern.role?(:student).should be_true
        @intern.role?(:extern).should be_false
        @intern.role?(:intern).should be_true
      end
    end
  end


  context '#scopes' do
    before do
      Factory(:student)
      Factory(:extern)
      Factory(:admin)
      i=Factory(:intern)
      Semester.stubs(:current).returns(i.semesters.last)
    end
    %w(extern admin intern).each do |role|
      it "should only return #{role}s" do
        users = User.with_role(role.to_sym).all
        users.count.should == 1
        users.each do |user|
          user.role?(role).should be_true
        end
      end
    end
    it 'should only return students' do
      users = User.with_role(:student).all
      users.count.should == 2
      users.each do |user|
        user.role?(:student).should be_true
      end
    end
  end

  context '#DN' do
    before(:each) do
      @dn = "cn=amy12345,ou=1,ou=stud,o=fooo,c=de"
    end

    it 'should return the cached_dn if available' do
      user = Factory.build(:amy, :cached_dn => @dn)
      user.dn.should == @dn
    end
    it 'should call fetchDN if nothing cached yet' do
      user = Factory.build(:amy, :cached_dn => nil)
      l = Ldap.new
      Ldap.expects(:new).returns(l)
      l.expects(:fetchDN).with(user.nds).returns(@dn)
      user.dn.should == @dn
    end
    it 'should save the DN in cached_dn if its newly fetched' do
      user = Factory.build(:amy, :cached_dn => nil)
      Ldap.any_instance.stubs(:fetchDN).returns(@dn)
      user.dn
      user.cached_dn.should == @dn
    end
  end

  context '#new_with_ldap' do
    before(:all) do
      @nds = "foo12345"
      @dn = "cn=#{@nds},ou=3,ou=stud,o=dev-test,c=de"
      @mail = "john.doe@stud.dev-test.de"
      @matnr = 3332224
      ldif = "dn: #{@dn}
urrzfullname: John Doe
mail: #{@mail}
urrzgivenname: John
cn: #{@nds}
uid: #{@nds}
urrzsurname: Doe
urrzmatrikelid: #{@matnr}"
      @entry = Net::LDAP::Entry.from_single_ldif_string(ldif)
    end

    it 'should be invalid if the entry is not a LDAP entry' do
      user = User.new_with_ldap(nil)
      user.should_not be_valid
    end

    it "should have the entry's values"  do
      user = User.new_with_ldap(@entry)
      user.nds.should == @nds
      user.dn.should == @dn
      user.email.should == @mail
      user.matnr.should == @matnr.to_s
    end

    it 'should be a student if stud in dn' do
      #its that way in the default entry, see before block
      #@entry.dn = "cn=#{@nds},ou=3,ou=stud,o=dev-test,c=de"
      user = User.new_with_ldap(@entry)
      user.role?(:student).should be_true
    end

    it 'should be a extern if no stud in dn' do
      @entry.dn = "cn=#{@nds},ou=3,o=dev-test,c=de"
      user = User.new_with_ldap(@entry)
      user.role?(:student).should be_false
      user.role?(:extern).should be_true
    end

    context '#create_with_ldap' do
      it 'should be a persitend user if the entry is a LDAP entry' do
        user = User.create_with_ldap!(@entry)
        user.persisted?.should be_true unless user.nil?
      end
    end
  end

  context '#search' do
    before(:each) do
      @u1 = Factory(:bob, :nds => 'tyu23232', :matnr => '8878878')
      @u2 = Factory(:amy, :nds => 'sdf53535', :matnr => '7747747')
      @u3 = Factory(:student, :nds => 'ghj92929', :matnr => '2202202')
      @u4 = Factory(:extern, :nds => 'okl012322', :matnr => '6616616')
      @u5 = Factory(:admin, :nds => 'pel18181', :matnr => '5535535')
    end
    it 'should find users named like the query' do
      q = 'Doe'
      User.search(q).entries.should == [@u1, @u2, @u3, @u4, @u5]
    end
    it 'should find users named like the query' do
      q = 'Amy'
      User.search(q).should == [@u2]
    end
    it 'should find users with nds like the query' do
      q = 'ghj'
      User.search(q).entries.should == [@u3]
    end
    it 'should find users with nds like the query' do
      q = '8878'
      User.search(q).entries.should == [@u1]
    end
  end
  context '#create' do
    it 'should look for students if the matnr is in the list of the currently unknown of the current semester' do
      semester = Factory(:current, :matrlist => "7777777")
      u3=Factory(:student, :matnr => "7777777")
      Semester.current.interns.should == [u3]
    end
  end
end

