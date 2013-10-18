module AutoError
  module ApplicationHelper
    def auto_error_js_namespace
      javascript_tag "window.AutoErrorApp = {};"
    end

    def auto_error_void_path
      'javascript:void(0);'
    end
  end
end
