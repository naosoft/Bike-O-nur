# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bikeonur_session',
  :secret      => '34035ad3ec029ed74db96c53c36a1288414001bbe8dd8a8fef647981296ec89519a36b4ae491bfe36a3f509ba2df8bd1215d587f3a1653994daba1c9fe334432'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
