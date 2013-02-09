require 'spec_helper'

describe 'AutoError::Config#error_template_renderer' do
  before( :each ) do
    AutoError::Config.setup do |config|
      config.error_template_renderer = ->( status ) do
        render template: 'errors/not_found', layout: 'errors', status: status
      end
    end
  end

  before( :each ) do
    post error_faker_path( klass: 'AutoError::Errors::NotFound', message: 'WAT?' )
  end

  it 'should render the configured template' do
    response.should render_template('errors/not_found')
    response.body.should include('Not Found')
  end
end
