guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^app/concepts/(.+)/operation/(.+).rb$})  { |m| "spec/concepts/#{m[1]}/#{m[2]}_spec.rb" }
end
