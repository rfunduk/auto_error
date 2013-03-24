module AutoError
  class AppErrorDecorator < Draper::Decorator
    def as_json( context )
      r = source.attributes
      (r['data']||{}).entries.each do |k, v|
        next if v.nil?
        k = k.to_sym
        if k != :params || AutoError::Config.data_handlers.has_key?(k)
          handler = AutoError::Config.data_handlers[k].bind(context)
          processed = handler.(v)
        elsif k == :params
          processed = handle_params(v)
        end
        r['data'][k.to_s] = processed.html_safe
      end
      r
    end

    private

    def handle_params( h )
      %{
        <a href='javascript:void(0);' onclick='$(this).siblings(".params").reveal();'>show params...</a>
        <div class='params reveal-modal'>
          <a class="close-reveal-modal">&#215;</a>
          <h4>Params</h4>
          <pre>#{JSON.pretty_generate(h)}</pre>
        </div>
      }
    end
  end
end
