# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mbo_session',
  :secret      => 'e7a4988c6061eba349a42e9b77324e79b35866cb517a15509c5c9591cbea9e6db5b9a253a4e5ebe0d9e649cf5e2f176c9170769eaa64939b048aba87c4286341'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
