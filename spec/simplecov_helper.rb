require 'simplecov'
require 'codecov'

# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start do
  add_filter '/spec'
  add_filter '/config'
  add_filter '/lib/tasks'
  add_filter '/channel'
  add_filter '/controllers'

  # TODO: Uncomment and delete row below when feature tests will be present
  add_filter 'render_helper'
  add_filter '/cell'
  # add_group 'Cells' do |src_file|
  #   src_file.project_filename.match(%r{\/cell})
  # end

  add_group 'Contracts' do |src_file|
    src_file.project_filename.match(%r{\/contract})
  end

  add_group 'Operations' do |src_file|
    src_file.project_filename.match(%r{\/operation})
  end

  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Services' do |src_file|
    src_file.project_filename.match(%r{\/services\/})
  end

  add_group 'Policies', 'app/policies'
end

if ENV['CODECOV_TOKEN']
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
