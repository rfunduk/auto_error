AutoError::Config.setup do |config|
  # == Authenticated User Method
  # Specify a Proc or :warden or :devise, depending on
  # your authentication scheme.

  # Examples:
  #
  # config.auth_with = Proc.new { |h| h.current_user }
  # config.auth_with = :warden
  config.auth_with = :warden
end
