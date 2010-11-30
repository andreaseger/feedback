require 'spec_helper'

describe Ldap do

  describe '#initialize' do
    it 'should use LDAP_CONFIG' do
      ldap = Ldap.new
      ldap.config[:host].should_not be_nil
      ldap.config[:port].should_not be_nil
      ldap.config[:base].should_not be_nil
    end
  end

  describe '#fetchDN' do
    # ask the LDAP server for the full DN of the user with the given nds
    before(:each) do
      @nds = "asd12345"
      @dn = "cn=#{@nds},ou=1,ou=stud,o=fooo,c=de"
      entries = [Net::LDAP::Entry.new(@dn)]
      Net::LDAP.any_instance.stubs(:search).returns(entries)
      @connection = Ldap.new
      @ldap = Net::LDAP.new(@connection.config)
    end
    it 'should create a new net::ldap object' do
      Net::LDAP.expects(:new).returns(@ldap)
      @connection.fetchDN(@nds)
    end
    it 'should set the ldap config' do
      Net::LDAP.expects(:new).with(@connection.config).returns(@ldap)
      @connection.fetchDN(@nds)
    end
    it 'should create a filter with cn=paramster' do
      Net::LDAP::Filter.expects(:eq).with("cn", @nds)
      @connection.fetchDN(@nds)
    end
    it 'should call search with the created filter' do
      fil = Net::LDAP::Filter.eq("cn", @nds)
      Net::LDAP.stubs(:new).returns(@ldap)
      Net::LDAP::Filter.stubs(:eq).returns(fil)
      @ldap.expects(:search).with(:filter => fil, :return_result => true)
      @connection.fetchDN(@nds)
    end
    describe '#only one entrie found' do
      it 'should return the entrie' do
        @connection.fetchDN(@nds).should == @dn
      end
    end
    describe '#multiple entries found' do
      before(:each) do
        entries = [Net::LDAP::Entry.new(@dn), Net::LDAP::Entry.new(@dn)]
        Net::LDAP.any_instance.stubs(:search).returns(entries)
      end
      it 'should return nil' do
        @connection.fetchDN(@nds).should be_nil
      end
    end
  end

end

