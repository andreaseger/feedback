class Ldap
  attr_accessor :config
  def initialize
    @config = { :host => LDAP_CONFIG["host"],
                    :port => LDAP_CONFIG["port"],  #evtl hier auch auf ssl wechseln
                    :base => LDAP_CONFIG["base"]}
  end
  def fetchDN(nds)
    c = Net::LDAP.new(@config)
    filter = Net::LDAP::Filter.eq("cn", nds)
    entries = c.search(:filter => filter, :return_result => true)
    if entries && entries.count == 1
      entries.first.dn
    else
      nil
    end
  end
end

