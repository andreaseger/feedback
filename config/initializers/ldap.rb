# load ldap yaml file
LDAP_CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/ldap.yml")[::Rails.env]

#Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :LDAP, LDAP_CONFIG["name"],
#                  :host => LDAP_CONFIG["host"],
#                  :port => LDAP_CONFIG["port_ssl"],
#                  :method => :ssl,
#                  :base => LDAP_CONFIG["base"],
#                  :uid => LDAP_CONFIG["uid"]
#end
#

