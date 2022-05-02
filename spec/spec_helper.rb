# frozen_string_literal: true

require 'webmock/rspec'
require 'factory_bot'
require 'faker'
require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'corelogic'
require 'factory_bot/json_strategy'

pathname = Pathname.new(Gem::Specification.find_by_name('corelogic-ruby').gem_dir)
Dir[pathname.join('spec', 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.definition_file_paths = Dir['spec/factory_bot/*.rb'].map do |f|
      "#{File.dirname(f)}/#{File.basename(f, File.extname(f))}"
    end
    FactoryBot.find_definitions
    FactoryBot.register_strategy(:json, JsonStrategy)
  end
end

CONSUMER_KEY = 'your_client_id'
CONSUMER_SECRET = 'your_client_secret'

Corelogic.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
end

def a_get(path)
  a_request(:get, Corelogic::Connection::BASE_PATH + path)
end
