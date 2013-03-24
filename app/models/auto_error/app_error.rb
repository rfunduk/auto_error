module AutoError
  class AppError < ActiveRecord::Base
    attr_accessible *%w{ controller action data klass message backtrace }

    before_create :generate_group

    serialize :data

    scope :unresolved, -> { where( resolved_at: nil ).order( 'created_at ASC' ) }

    def self.log!( env, exception, opts, data={} )
      opts[:data] = data
      opts[:data].merge! self.context(env)
      opts.merge!( {
        klass: exception.class.name,
        message: exception.message,
        backtrace: (
          exception.backtrace ? clean_backtrace(exception.backtrace) : []
        ).join("\n")
      } )
      app_error = create!( opts )

      if AutoError::Config.email_on_error.any?
        begin
          send_email!( env, exception, opts[:data] )
        rescue
          $stderr.puts "AutoError failed to send exception notification email to #{AutoError::Config.email_on_error.inspect} -- #{$!.inspect}"
        end
      end

      app_error
    end

    class << self
      def add_context( env, opts )
        context(env).merge!( opts )
      end
      def context( env )
        env['auto_error.app_error.context'] ||= {}
        env['auto_error.app_error.context']
      end
      def clear_context!( env )
        env['auto_error.app_error.context'] = {}
      end
    end

    private

    def self.send_email!( env, exception, data )
      options = env['exception_notifier.options'] || {}
      options[:ignore_exceptions] ||= ExceptionNotifier.default_ignore_exceptions
      options[:email_prefix] ||= "[#{Rails.application.class.name.split('::').first} ERROR] "
      options[:exception_recipients] = AutoError::Config.email_on_error
      options[:data] = data

      unless Array.wrap(options[:ignore_exceptions]).include?( exception.class )
        ExceptionNotifier::Notifier.exception_notification( env, exception, options ).deliver
        env['exception_notifier.delivered'] = true
      end
    end

    def self.clean_backtrace( backtrace )
      return backtrace unless Rails.respond_to?( :backtrace_cleaner )
      Rails.backtrace_cleaner.send( :filter, backtrace )
    end

    def generate_group
      self.group = Digest::SHA1.hexdigest( [
        self.klass.to_s, self.message.to_s,
        self.controller.to_s, self.action.to_s
      ].join('-') ).to_s
    end
  end
end
