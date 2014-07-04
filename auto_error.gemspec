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
    AutoError is a mountable engine for Rails 4.0+ which provides
    an 'exceptions_app' which helps you catch exceptions (showing
    the appropriate page to users) and an interface you can mount
    in your admin panel to display those errors.
  }

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_runtime_dependency 'rails', '~> 4.0'
  s.add_runtime_dependency 'haml', '~> 4.0'
  s.add_runtime_dependency 'draper', '~> 1.3'
  s.add_runtime_dependency 'exception_notification', '~> 4.0'
  s.add_runtime_dependency 'jquery-rails', '~> 3.0'
  s.add_runtime_dependency 'handlebars_assets', '~> 0.16'
  s.add_runtime_dependency 'coffee-rails', '~> 4.0'
  s.add_runtime_dependency 'sprockets-rails', '>= 2.0'

  s.add_development_dependency 'sqlite3', '~> 1.3'
  s.add_development_dependency 'bcrypt-ruby', '~> 3.1'
  s.add_development_dependency 'rspec-rails', '~> 2.14'
  s.add_development_dependency 'fabrication', '~> 2.9'
  s.add_development_dependency 'faker', '~> 1.2'
  s.add_development_dependency 'do_not_want', '0.0.1'
end
