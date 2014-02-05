require 'spec_helper'

describe AutoError::AppErrorDecorator do
  let!(:env) { ActionDispatch::Request.new( { 'rack.input' => StringIO.new } ) }

  before( :each ) do
    AutoError::Config.setup do |config|
      config.data_handlers[:x] = ->(v) do
        link_to( '', root_path( x: v ) )
      end
    end
  end

  describe 'uses data handlers' do
    before( :each ) do
      exception = ArgumentError.new('Message')
      exception.set_backtrace( "Backtrace\nhere" )
      @error = log_error!( env, exception, {}, { x: 1 } )
      @decorated = AutoError::AppErrorDecorator.decorate(@error)
    end

    it 'should call the x helper' do
      expect { @json = @decorated.as_json }.to_not raise_error
      expect(@json['data']['x']).to be "<a href='/?x=1'></a>"
    end
  end
end
