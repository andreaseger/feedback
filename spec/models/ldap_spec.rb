require 'spec_helper'

describe Ldap do
  before(:all) do
    @nds = "asd12345"
    @dn = "cn=#{@nds},ou=1,ou=stud,o=fooo,c=de"
    @password = 'secret'
    @connection = Ldap.new
    @ldap = Net::LDAP.new(@connection.config)
  end

  context '#initialize' do
    it 'should use LDAP_CONFIG' do
      ldap = Ldap.new
      ldap.config[:host].should_not be_nil
      ldap.config[:port].should_not be_nil
      ldap.config[:base].should_not be_nil
    end
  end

  context '#fetchData' do
    # ask the LDAP server for all infos on the user
    before(:each) do
      @entry = Net::LDAP::Entry.new(@dn)
      Net::LDAP.any_instance.stubs(:search).returns([@entry])
    end
    it 'should create a new net::ldap object' do
      Net::LDAP.expects(:new).returns(@ldap)
      @connection.fetchData(@nds)
    end
    it 'should set the ldap config' do
      Net::LDAP.expects(:new).with(@connection.config).returns(@ldap)
      @connection.fetchData(@nds)
    end
    it 'should create a filter with cn=paramster' do
      Net::LDAP::Filter.expects(:eq).with("cn", @nds)
      @connection.fetchData(@nds)
    end
    it 'should call search with the created filter' do
      fil = Net::LDAP::Filter.eq("cn", @nds)
      Net::LDAP.stubs(:new).returns(@ldap)
      Net::LDAP::Filter.stubs(:eq).returns(fil)
      @ldap.expects(:search).with(:filter => fil, :return_result => true)
      @connection.fetchData(@nds)
    end
    context '#only one entrie found' do
      it 'should return the entrie' do
        @connection.fetchData(@nds).should == @entry
      end
    end
    context '#multiple entries found' do
      before(:each) do
        entries = [Net::LDAP::Entry.new(@dn), Net::LDAP::Entry.new(@dn)]
        Net::LDAP.any_instance.stubs(:search).returns(entries)
      end
      it 'should return nil' do
        @connection.fetchData(@nds).should be_nil
      end
    end
  end

  context '#fetchDN' do
    before(:all) do
      @nds = "asd12345"
      @dn = "cn=#{@nds},ou=1,ou=stud,o=fooo,c=de"
      @connection = Ldap.new
      @entry = Net::LDAP::Entry.new(@dn)
    end

    it 'should call fetchData' do
      @connection.expects(:fetchData).with(@nds)
      @connection.fetchDN(@nds)
    end

    it 'should return the DN of the received DATA' do
      @connection.stubs(:fetchData).returns(@entry)
      @connection.fetchDN(@nds).should == @dn
    end

    it 'should return nil if the data was nil' do
      @connection.stubs(:fetchData).returns(nil)
      @connection.fetchDN(@nds).should be_nil
    end
  end


  context '#authenticate' do
    before(:each) do
      @ldap.stubs(:bind).returns(true)
    end
    it 'should create a ldap object' do
      Net::LDAP.expects(:new).returns(@ldap)
      @connection.authenticate(@dn, @password)
    end

    it 'should initialize with ssl' do
      config = @connection.config.merge(:encryption => :simple_tls, :port => LDAP_CONFIG["ssl"])
      ldap = Net::LDAP.new(config)
      ldap.stubs(:bind).returns(true)
      Net::LDAP.expects(:new).with(config).returns(ldap)
      @connection.authenticate(@dn, @password)
    end

    it 'should authenticate with the ldap server' do
      Net::LDAP.stubs(:new).returns(@ldap)
      @ldap.expects(:auth).with(@dn, @password)
      @ldap.expects(:bind)
      @connection.authenticate(@dn, @password)
    end


    it 'should return true if bind returns true' do
      Net::LDAP.stubs(:new).returns(@ldap)
      @ldap.expects(:bind).returns(true)
      @connection.authenticate(@dn, @password).should be_true
    end

    it 'should return true if bind returns true' do
      Net::LDAP.stubs(:new).returns(@ldap)
      @ldap.expects(:bind).returns(false)
      @connection.authenticate(@dn, @password).should be_false
    end
  end
  context '#AuthenticateAndFetch' do
    before(:each) do
      @entry = Net::LDAP::Entry.new(@dn)
      @connection.stubs(:fetchDN).returns(@dn)
    end

    it 'should call fetchDN' do
      Net::LDAP.stubs(:new).returns(@ldap)
      @ldap.stubs(:bind).returns(false)
      @connection.expects(:fetchDN).with(@nds).returns(@dn)
      @connection.authenticate_and_fetch(@nds, @password)
    end

    it 'should initialize with ssl' do
      config = @connection.config.merge(:encryption => :simple_tls, :port => LDAP_CONFIG["ssl"])
      ldap = Net::LDAP.new(config)
      ldap.stubs(:bind).returns(true)
      ldap.stubs(:search).returns([@entry])
      Net::LDAP.expects(:new).with(config).returns(ldap)
      @connection.authenticate_and_fetch(@nds, @password)
    end

    it 'should authenticate with the ldap server' do
      Net::LDAP.stubs(:new).returns(@ldap)
      @ldap.expects(:auth).with(@dn, @password)
      @ldap.expects(:bind)
      @connection.authenticate_and_fetch(@nds, @password)
    end
    it 'should search for the users data' do
      Net::LDAP.stubs(:new).returns(@ldap)
      @ldap.stubs(:bind).returns(true)
      fil = Net::LDAP::Filter.eq("dn", @nds)
      Net::LDAP::Filter.expects(:eq).returns(fil)
      @ldap.expects(:search).returns([@entry])
      @connection.authenticate_and_fetch(@nds, @password)
    end
  end
end

