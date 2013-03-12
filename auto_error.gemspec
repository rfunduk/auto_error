$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "auto_error/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "auto_error"
  s.version     = AutoError::VERSION

  s.required_ruby_version = '>= 1.9.3'

  s.author      = "Ryan Funduk"
  s.email       = "ryan.funduk@gmail.com"
  s.homepage    = "http://ryanfunduk.com"

  s.license     = 'MIT'
  s.summary     = "A rails engine for in-app exception handling."
  s.description = %{
    AutoError is a mountable engine for Rails 3.2+ which provides
    an 'exceptions_app' which helps you catch exceptions (showing
    the appropriate page to users) and an interface you can mount
    in your admin panel to display those errors.
  }

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'rails', '>= 3.2.0'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'haml'
  s.add_dependency 'draper'
  s.add_dependency 'exception_notification'
  s.add_dependency 'sprockets-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'handlebars_assets'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'bcrypt-ruby'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'fabrication'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'do_not_want'
end
