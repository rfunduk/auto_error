module AutoError
  class AuthContext
    def initialize( env )
      AutoError::Config.auth_helpers.each do |mod_name|
        mod = Rails.application.class.qualified_const_get(mod_name)
        class_eval do
          send( :include, mod )
          mod.instance_methods.each do |imeth|
            alias :"#{imeth}_without_env" :"#{imeth}"
            send( :define_method, imeth ) do
              method( :"#{imeth}_without_env" ).to_proc.bind( env )
            end
          end
        end
      end
    end
  end
end
