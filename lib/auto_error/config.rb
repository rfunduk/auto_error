module AutoError
  module Config
    def self.setup( &blk )
      yield self
    end

    mattr_accessor :auth_with
    @@auth_with = nil

    mattr_accessor :auth_helpers
    @@auth_helpers = nil

    mattr_accessor :email_on_error
    @@email_on_error = nil

    mattr_accessor :error_template_renderer
    @@error_template_renderer = nil

    mattr_accessor :data_handlers
    @@data_handlers = nil

    private

    def self.set_defaults
      self.setup do |config|
        config.error_template_renderer = ->( status ) do
          render template: "/errors/#{status}", layout: 'errors', status: status
        end

        config.email_on_error = []

        config.auth_with = ->( c ) { true }
        config.auth_helpers = [ 'ApplicationHelper' ]

        config.data_handlers = Hash.new { |h, k| h[k] = ->( value ) { "<strong>#{value}</strong>" } }
      end
    end
  end
end
