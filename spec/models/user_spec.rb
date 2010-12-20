require 'spec_helper'

describe User do
  describe '#validations' do
    it 'nds should be unique' do
      Factory(:bob, :nds => "abc12345")
      user = Factory.build(:amy, :nds => "abc12345")
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

    describe '#roles' do
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

  describe '#role?' do
    before(:each) do
      @admin = Factory.build(:admin)
      @student = Factory.build(:student)
      @extern = Factory.build(:extern)
      @intern = Factory(:student)
      semester = Factory(:semester, :interns => [@intern])
      Semester.stubs(:current).returns(semester)
    end

    describe 'should be true for the right role' do
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


  describe '#scopes' do
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

  describe '#DN' do
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

  describe '#new_with_ldap' do
    before(:all) do
      @nds = "foo12345"
      @dn = "cn=#{@nds},ou=3,ou=stud,o=dev-test,c=de"
      @mail = "john.doe@stud.dev-test.de"
      ldif = "dn: #{@dn}
urrzfullname: John Doe
mail: #{@mail}
urrzgivenname: John
cn: #{@nds}
uid: #{@nds}
urrzsurname: Doe"
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
end

