require 'spec_helper'

describe AutoError::AppError do
  let!(:env) { ActionDispatch::Request.new( { 'rack.input' => StringIO.new } ) }

  describe 'context' do
    it 'should maintain a context' do
      AutoError::AppError.add_context( env, { 'test' => true } )
      expect( env['auto_error.app_error.context'] ).to eq( 'test' => true )
    end
  end

  describe 'logs an error' do
    before( :each ) do
      exception = ArgumentError.new('Message')
      exception.set_backtrace( "Backtrace\nhere" )
      @error = log_error!( env, exception )
    end

    it 'should be logged' do
      expect( @error ).to_not be_nil
      expect( AutoError::AppError.count ).to eq(1)
    end

    it 'should have a message' do
      expect( @error.message ).to eq('Message')
    end
  end
end
