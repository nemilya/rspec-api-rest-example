RSpec API REST test example
===========================

Example of RSpec testing web rest-api backend (json) Sinatra based.


Init rspec
----------

    rspec --init .


Start autotest
--------------

Run `autotest` in folder:


    autotest .


For windows:

    start autotest .



Create stub specification for api
---------------------------------

File `spec/spec_helper.rb`


```ruby
require 'spec_helper.rb'

describe 'API' do
  it "Start page ok" do
    get "/"
    last_response.should be_ok
  end
end
```


Create stub sinatra api application
-----------------------------------

File `api.rb`:

```ruby
require "sinatra"

get '/' do
  'rspec-api-rest-example'
end
```



Configure RSpec for Rack::Test
------------------------------

Add `require 'rack/test'` and `config.include Rack::Test::Methods`, in `spec_helper.rb` file:


    require 'rack/test'

    RSpec.configure do |config|
      config.include Rack::Test::Methods
    end


Init Sinatra application instance for RSpec
-------------------------------------------

Add `require 'sinatra'` and:

```ruby
def app
  Sinatra::Application
end
```

to `spec_helper.rb` file.

Add `require 'api.rb'` to `spec_helper.rb` file.


Add test for start page content
-------------------------------

Add to `api_spec.rb` file:

```ruby
it "Start content" do
  get "/"
  last_response.body.should == 'rspec-api-rest-example'
end
```


Create User DataMapper model
----------------------------

Create `lib/user.rb` model:

```ruby
class User
  include DataMapper::Resource

  property :id,   Serial, :key => true
  property :name, String
end
```

Install DataMapper, sqlite3 datamapper-driver, 
sqlite3 dll (for windows), configure RSpec helper, 
sqlite3 database name, configure .autotest

See details here https://github.com/nemilya/rspec-datamapper-example


Specification to API /api/users.json
------------------------------------

Add new test to `api_spec.rb` file:

```ruby
it "/api/users.json" do
  # create in data base
  User.create(:name=>'User 1')
  User.create(:name=>'User 2')

  # get REST GET request
  get "/api/users.json"

  # test 'ok' response
  last_response.should be_ok

  # parse JSON
  info = JSON::parse(last_response.body)
  info.size.should == 2
  info[0]['name'].should == 'User 1'
  info[1]['name'].should == 'User 2'
end        
```

Create API REST /api/users.json implementation
----------------------------------------------

In `api.rb` file:

```ruby
get '/api/users.json' do
  ret = []
  User.all.each do |u|
    ret << { :name=> u.name }
  end
  ret.to_json
end
```


Configure DataBase cleanup before each test
-------------------------------------------

Within `describe` module in `api_spec.rb` file add:

```ruby
before(:each) do
  # cleanup database
  User.all.destroy
end
```

Specification API REST POST /api/user_add.json
----------------------------------------------

```ruby
it "POST /api/user_add.json" do
  User.count.should == 0

  # POST request, for create User with 'name' parametr
  post '/api/user_add.json', { :name=>"New User" }

  # test in database
  User.count.should == 1

  # test in database
  User.first.name.should == 'New User'
end
```

Create implementation for API REST POST /api/user_add.json
----------------------------------------------------------

In `api.rb` file:

```ruby
post '/api/user_add.json' do
  user = User.new
  user.name = params[:name]
  user.save
end
```


Documentation
=============

Great documentation about RSpec can be found here:
https://www.relishapp.com/rspec/