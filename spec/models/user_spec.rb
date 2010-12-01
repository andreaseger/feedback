require 'spec_helper'

describe User do
  describe '#validations' do
    describe '#nds' do
      it 'should be unique' do
        Factory(:bob, :nds => "abc12345")
        user = Factory.build(:amy, :nds => "abc12345")
        user.should_not be_valid
      end
      it 'should be present' do
        user = Factory.build(:amy, :nds => nil)
        user.should_not be_valid
      end
    end
  end

  describe '#scopes' do
    before do
      Factory(:amy)#student
      Factory(:intern)
      Factory(:prof)
      Factory(:admin)
    end
    it 'should only return students' do
      users = User.with_role("student").all
      users.count.should == 2
      users.each do |user|
        user.role?("student").should be_true
      end
    end
    %w(intern prof admin).each do |role|
      it "should only return #{role}s" do
        users = User.with_role(role).all
        users.count.should == 1
        users.each do |user|
          user.role?(role).should be_true
        end
      end
    end
  end

  describe '#roles' do
    it 'should not allow interns who are no students' do
      user = Factory.build(:bob, :roles => ["intern"])
      user.should_not be_valid
    end
    it 'should not allow users to be student and prof at the same time' do
      user = Factory.build(:bob, :roles => ["student", "prof"])
      user.should_not be_valid
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

  describe '#create_with_ldap' do
    #TODO
  end
end

