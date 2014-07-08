require 'collect_plus'

require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  WebMock.disable_net_connect!(allow_localhost: true)
end
