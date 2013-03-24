require 'spec_helper'

describe 'AutoError::Config#data_handlers' do
  before( :each ) do
    AutoError::Config.setup do |config|
      config.data_handlers[:test] = ->( value ) do
        path = root_path( test: value )
        link_to( value, path )
      end
    end
  end

  let!(:app_error) { Fabricate(:app_error, data: { test: 5 } ) }

  it 'supports custom data handlers' do
    context = AutoError::HelperContext.new({})
    json = AutoError::AppErrorDecorator.new(app_error).as_json(context)
    json['data']['test'].should == '<a href="/?test=5">5</a>'
  end
end
