class Ldap
  attr_accessor :config
  def initialize
    @config = { :host => LDAP_CONFIG["host"],
                    :port => LDAP_CONFIG["port"],  #evtl hier auch auf ssl wechseln
                    :base => LDAP_CONFIG["base"]}
    #@do_auth = LDAP_CONFIG["authenticate"]
  end
  def fetchDN(nds)
    data = fetchData(nds)
    if data
      return data.dn
    else
      nil
    end
  end

  def authenticate(dn, password)
    c = Net::LDAP.new(@config.merge(:encryption => :simple_tls, :port => LDAP_CONFIG["ssl"]))
    c.auth(dn, password)
    if c.bind
      true
    else
      false
    end
  end

  def fetchData(nds)
    c = Net::LDAP.new(@config)
    filter = Net::LDAP::Filter.eq("cn", nds)
    entries = c.search(:filter => filter, :return_result => true)
    if entries && entries.count == 1
      entries.first
    else
      nil
    end
  end
end

