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