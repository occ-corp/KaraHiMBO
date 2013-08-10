require 'active_ldap'

class LdapAuthenticator < ActiveLdap::Base
  ldap_mapping :dn_attribute => "cn", :prefix => "ou=Users"

  def self.authenticate(login, password)
    user = find(login)
    user.bind(password)
    return true
  end
end
