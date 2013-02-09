module AutoError
  module ApplicationHelper
    def js_namespace
      h = {} # nothing needed, really
      javascript_tag "window.App = #{h.to_json.html_safe};"
    end

    def void_path
      'javascript:void(0);'
    end
  end
end
