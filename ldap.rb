require "active_ldap"

require_relative "config"

class User < ActiveLdap::Base
	ldap_mapping dn_attribute: "mail",
				 prefix: "",
				 classes: ["inetOrgPerson"]

	def User.authenticate(mail, password)
		user = find(:first, filter: { mail: mail })
		user.bind(password)
		user
	rescue ActiveLdap::EntryNotFound, ActiveLdap::AuthenticationError, ActiveLdap::LdapError::UnwillingToPerform, NoMethodError
		nil
	end
end
