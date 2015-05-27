require 'bundler/gem_tasks'
require 'cucumber'
require 'cucumber/rake/task'
require 'yard'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = 'features --format pretty'
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/rankle.rb']
end

task :default => [:test, :features, :yard]
