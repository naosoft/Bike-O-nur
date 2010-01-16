
require 'digest/sha1'

class User < ActiveRecord::Base


 attr_accessor :remember_me
 attr_accessor :current_password



#max i min  -> dlugosc strigow wrowadzanych do poszczegolnych pol

LOGIN_MIN_LENGTH = 3
LOGIN_MAX_LENGTH = 20

PASSWORD_MIN_LENGTH = 4
PASSWORD_MAX_LENGTH = 40

EMAIL_MAX  = 50


LOGIN_RANGE = LOGIN_MIN_LENGTH..LOGIN_MAX_LENGTH
PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH

#max dla dlugosci boxow
LOGIN_SIZE = 20
PASSWORD_SIZE = 20
EMAIL_SIZE = 30

#walidatory 

validates_uniqueness_of :login, :email
validates_confirmation_of :password
validates_length_of :login, :within => LOGIN_RANGE
validates_length_of :password, :within => PASSWORD_RANGE
validates_length_of :email, :maximum => EMAIL_MAX

#definowanie formatu 

validates_format_of :login,
                    :with =>/^[A-Z0-9._%-]*$/i,
                    :message => " tylko litery cyfry i podkreslenia"



validates_format_of :email,
                     :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                     :message => "aders maiowy nie jest poprawny"


def validate
    # Protect against overwriting default thumbnail...
    if %w(default_thumbnail default).include?(login)
      errors.add(:login, "cannot be that, nice try though")
    end
  end

  # Log a user in.
  def login!(session)
    session[:user_id] = id
  end

  # Log a user out.
  def self.logout!(session, cookies)
    session[:user_id] = nil
    cookies.delete(:authorization_token)
  end

  # Clear the password (typically to suppress its display in a view).
  def clear_password!
    self.password = nil
    self.password_confirmation = nil
    self.current_password = nil
  end

  # Remember a user for future login.
  def remember!(cookies)
    cookie_expiration = 10.years.from_now
    cookies[:remember_me] = { :value   => "1",
                              :expires =>  cookie_expiration }
    self.authorization_token =  unique_identifier
    save!
    cookies[:authorization_token] = { :value   => authorization_token,
                                      :expires => cookie_expiration }
  end

  # Forget a user's login status.
  def forget!(cookies)
    cookies.delete(:remember_me)
    cookies.delete(:authorization_token)
  end

  # Return true if the user wants the login status remembered.
  def remember_me?
    remember_me == "1"
  end

  # Return true if the password from params is correct.
  def correct_password?(params)
    current_password = params[:user][:current_password]
    password == current_password
  end

  # Generate messages for password errors.
  def password_errors(params)
    # Use User model's valid? method to generate error messages
    # for a password mismatch (if any).
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    valid?
    # The current password is incorrect, so add an error message.
    errors.add(:current_password, "is incorrect")
  end


def name 
  #spec.full_name.or_else(login)
end

private 

def unique_identifier 
  Digest::SHA1.hexdigest("#{login}:#{password}")
end
end

