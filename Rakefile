require 'bundler/setup'
require 'rake/testtask'
require 'dotenv'

Dotenv.load

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
  puts FileList['test/**/*_test.rb']
end

task :default => :test
