# -*- coding: utf-8 -*-
require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  # validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  # validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  belongs_to :employee

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    begin

      method = 'ldap'

      case method
      when 'ldap' # production
        if LdapAuthenticator.authenticate(login, password)
          return find_by_login(login.downcase)
        else
           nil
        end
      when 'local' # development
        return nil if login.blank? || password.blank?
        u = find_by_login(login.downcase) # need to get the salt
        return u && u.authenticated?(password) ? u : nil
      else
        # raise NoMethodError
        return nil if login.blank? || password.blank?
        u = find_by_login(login.downcase) # need to get the salt
      end
    rescue ActiveLdap::AuthenticationError
      # LDAP 認証に失敗したらローカル認証('admin 専用')
      return nil if login.blank? || password.blank?
      u = find_by_login(login.downcase) # need to get the salt
      return u && u.authenticated?(password) ? u : nil
    rescue ActiveLdap::LdapError::UnwillingToPerform
      nil
    rescue ActiveLdap::ConnectionError
      raise ArgumentError.new(I18n.t(:user_could_not_connect_ldap))
    rescue NoMethodError
      raise ArgumentError.new(I18n.t(:user_no_authentication_method))
    end
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  #protected

  def employee_name
    return employee.name
  end

end
