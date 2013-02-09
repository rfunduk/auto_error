module AutoError
  class AppErrorDecorator < Draper::Decorator
    def as_json
      r = source.attributes
      (r['data']||{}).entries.each do |k, v|
        next if v.nil?
        handler = AutoError::Config.data_handlers[k.to_sym].bind(ViewContext.new)
        r['data'][k.to_s] = handler.(v).html_safe
      end
      r
    end
  end
end
