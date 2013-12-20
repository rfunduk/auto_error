require 'spec_helper'

describe 'AutoError::Config#email_on_error' do
  before( :each ) do
    AutoError::Config.setup do |config|
      config.email_on_error << 'test@example.com'
    end
    ActionMailer::Base.deliveries = []
  end

  it 'should email a notification' do
    log_error!( ActionDispatch::Request.new({ 'rack.input' => StringIO.new }), ArgumentError.new('test') )
    expect( AutoError::AppError.count ).to eq 1
    expect( ActionMailer::Base.deliveries.length ).to eq 1

    mail = ActionMailer::Base.deliveries.first
    expect( mail.to ).to eq(['test@example.com'])
  end
end
