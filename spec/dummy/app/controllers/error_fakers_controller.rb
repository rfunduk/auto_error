class ErrorFakersController < ApplicationController
  before_filter :clean_error_context

  def new
    @error_classes = %w{
      ArgumentError
      NotFound
      RuntimeError
      SyntaxError
    }
  end

  def create
    klass = Object.qualified_const_get( params[:klass] )
    unless klass.ancestors.include?(Exception)
      raise ArgumentError.new( "#{klass.name.to_s} is not an Exception!" )
    end

    begin
      data = JSON.parse( params[:data] )
      add_error_context( data )
    rescue
      # that's cool
    end

    e = klass.new( params[:message] || "Message" )
    e.set_backtrace( caller )

    raise e
  end

  private

  def clean_error_context
    clear_error_context
  end

end
