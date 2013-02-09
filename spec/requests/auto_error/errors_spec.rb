require 'spec_helper'

describe AutoError::ErrorsController do
  describe ArgumentError do
    before( :each ) do
      post error_faker_path( klass: 'ArgumentError', message: 'Nope!' )
    end

    it 'should be a 500' do
      response.status.should == 500
    end

    it 'should render the dummy 500 template' do
      response.should render_template('errors/500')
      response.body.should include('Dummy 500')
    end

    it 'should result in an AppError' do
      AutoError::AppError.count.should == 1
    end
  end

  describe AutoError::Errors::NotFound do
    before( :each ) do
      post error_faker_path( klass: 'AutoError::Errors::NotFound', message: 'WAT?' )
    end

    it 'should be a 404' do
      response.status.should == 404
    end

    it 'should render the engine 404 template' do
      response.should render_template('errors/404')
      response.body.should include('Engine 404')
    end

    it 'should not result in an AppError' do
      AutoError::AppError.count.should == 0
    end
  end
end
