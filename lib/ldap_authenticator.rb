require 'active_ldap'

ActiveLdap::Base.setup_connection :host => "ldap.example.co.jp", :base => "dc=example,dc=co,dc=jp"

class LdapAuthenticator < ActiveLdap::Base
  ldap_mapping :dn_attribute => "cn", :prefix => "ou=Users"

  def self.authenticate(login, password)
    user = find(login)
    user.bind(password)
    return true
  end
end
