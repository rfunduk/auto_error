module AutoError
  class ViewContext
    def initialize
      class_eval do
        self.send( :include, ActionView::Helpers )
        self.send( :include, Rails.application.routes.url_helpers )
      end
    end
  end
end
