require 'fileutils'
require 'digest'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.around(:example) do |example|
    FileUtils.rm_r Dir.glob('./tmp/*')
    example.run
    FileUtils.rm_r Dir.glob('./tmp/*')
  end
end
