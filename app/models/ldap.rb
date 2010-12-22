class Ldap
  attr_accessor :config
  def initialize
    @config = { :host => LDAP_CONFIG["host"],
                    :port => LDAP_CONFIG["port"],  #evtl hier auch auf ssl wechseln
                    :base => LDAP_CONFIG["base"]}
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
    return search(c,filter)
    nil
  end

  def authenticate_and_fetch(nds, password)
    if dn = fetchDN(nds)
      c = Net::LDAP.new(@config.merge(:encryption => :simple_tls, :port => LDAP_CONFIG["ssl"]))
      c.auth(dn,password)
      if c.bind
        filter = Net::LDAP::Filter.eq("dn", dn)
        return search(c,filter)
      end
    end
    nil
  end

  private

  def search(ldap, filter)
    entries = ldap.search(:filter => filter, :return_result => true)
    if entries && entries.count == 1
      return entries.first
    end
    nil
  end
end

