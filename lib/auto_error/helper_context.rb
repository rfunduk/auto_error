module AutoError
  class HelperContext
    attr_accessor :env

    def initialize( env )
      @env = env

      AutoError::Config.helpers.each do |mod_name|
        # grab the module by name we were given
        # it is available in the 'parent' Rails.application
        mod = Rails.application.class.qualified_const_get(mod_name)

        class_eval do
          # include that module in this HelperContext
          send( :include, mod )

          # but go through all of its instance methods
          # and alias-method-chain style twiddle them so we can bind
          # them to the correct environment inside auto_error
          mod.instance_methods.each do |imeth|
            alias :"#{imeth}_without_env" :"#{imeth}"
            send( :define_method, :"#{imeth}" ) do |*args|
              env.instance_exec( *args, &method( :"#{imeth}_without_env" ) )
            end
          end

          # also include rails helpers and ActionView helpers
          send( :include, ActionView::Helpers )
          send( :include, Rails.application.routes.url_helpers )
        end
      end
    end

    def default_url_options; {}; end
  end
end
