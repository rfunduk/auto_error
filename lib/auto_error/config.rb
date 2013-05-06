module AutoError
  module Config
    def self.setup( &blk )
      yield self
    end

    mattr_accessor :auth_with
    @@auth_with = nil

    mattr_accessor :helpers
    @@helpers = nil

    mattr_accessor :email_on_error
    @@email_on_error = nil

    mattr_accessor :email_sender
    @@email_sender =

    mattr_accessor :error_template_renderer
    @@error_template_renderer = nil

    mattr_accessor :data_handlers
    @@data_handlers = nil

    private

    def self.set_defaults
      self.setup do |config|
        config.error_template_renderer = ->( status ) do
          render template: "/errors/#{status}",
                 layout: 'errors',
                 status: status
        end

        config.email_sender = %{"Notifier" notifications@example.com}
        config.email_on_error = []
        ExceptionNotifier::Notifier.prepend_view_path(
          AutoError::Engine.root.join( *%w{app views auto_error} )
        )

        config.auth_with = ->( c ) { true }
        config.helpers = [ 'ApplicationHelper' ]

        config.data_handlers = Hash.new do |h, k|
          h[k] = ->( value ) { "<strong>#{value}</strong>" }
        end
      end
    end
  end
end
