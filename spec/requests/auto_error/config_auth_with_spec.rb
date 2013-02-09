require 'spec_helper'

describe 'AutoError::Config#auth_with' do
  describe 'no configured authentication' do
    before( :each ) { get app_errors_path }
    it 'should be allowed' do
      expect( response.status ).to eq(200)
    end
  end

  describe 'valid authentication' do
    before( :each ) do
      Administrator.create(
        name: 'Foo Bar', email: 'foo@bar.com',
        password: '12345', password_confirmation: '12345'
      )
      @app_error = Fabricate( :app_error )
      AutoError::Config.setup do |config|
        config.auth_with = ->( context ) do
          !context.current_admin.nil?
        end
      end
    end

    before( :each ) do
      post sessions_path( email: 'foo@bar.com', password: '12345' )
      get app_errors_path
    end

    it 'should return json' do
      expect( response.status ).to eq(200)
      expect { @json = JSON.parse( response.body ) }.to_not raise_error
      expect( @json ).to be_an(Array)
      expect( @json.first['id'] ).to eq( @app_error.id )
    end
  end

  describe 'invalid authentication' do
    before( :each ) do
      AutoError::Config.setup do |config|
        config.auth_with = ->( context ) { false }
      end
    end

    before( :each ) do
      get app_errors_path
    end

    it 'should be denied' do
      expect( response.status ).to eq(403)
    end
  end
end
