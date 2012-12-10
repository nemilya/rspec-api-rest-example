require 'spec_helper.rb'

describe 'API' do
  it "Start page ok" do
    get "/"
    last_response.should be_ok
  end

  it "Start content" do
    get "/"
    last_response.body.should == 'rspec-api-rest-example'
  end

end
