guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{^bin/}) { 'spec' }
end
