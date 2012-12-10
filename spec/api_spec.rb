require 'spec_helper.rb'

describe 'API' do

  before(:each) do
    # cleanup database
    User.all.destroy
  end

  it "Start page ok" do
    get "/"
    last_response.should be_ok
  end

  it "Start content" do
    get "/"
    last_response.body.should == 'rspec-api-rest-example'
  end

  it "/api/users.json" do
    # create in data base
    User.create(:name=>'User 1')
    User.create(:name=>'User 2')

    # get REST GET request
    get "/api/users.json"

    # test 'ok' respone
    last_response.should be_ok

    # parse JSON
    info = JSON::parse(last_response.body)
    info.size.should == 2
    info[0]['name'].should == 'User 1'
    info[1]['name'].should == 'User 2'
  end

  it "POST /api/user_add.json" do
    User.count.should == 0

    # POST request, for create User with 'name' parametr
    post '/api/user_add.json', { :name=>"New User" }

    # test in database
    User.count.should == 1

    # test in database
    User.first.name.should == 'New User'
  end


end