require 'bundler/gem_tasks'
require 'yard'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/rankle.rb']
end

task :default => [:test, :yard]
