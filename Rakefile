require 'bundler/gem_tasks'
require 'cucumber'
require 'cucumber/rake/task'
require 'yard'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = 'features --format pretty'
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/rankle.rb']
end

task :default => [:features, :yard]
