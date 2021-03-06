$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

if ENV['COVERAGE']
  require 'simplecov'
  project_root = File.expand_path('../../../..', __FILE__)
  SimpleCov.coverage_dir(File.join(project_root, 'coverage'))
  SimpleCov.start
end

PROJECT_RUBY_VERSION = ENV.fetch('PROJECT_RUBY_VERSION', '2.2.6')

require 'fakefs/spec_helpers'

require 'cloud'
require 'cloud/vsphere'

require 'base64'

Dir[Pathname(__FILE__).parent.join('support', '**/*.rb')].each { |file| require file }

class VSphereSpecConfig
  attr_accessor :logger, :uuid
end

RSpec.configure do |config|
  config.include Support

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end

  config.before do
    expect(RUBY_VERSION).to eq(PROJECT_RUBY_VERSION)
  end
end
