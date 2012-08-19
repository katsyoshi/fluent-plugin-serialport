require "bundler/gem_tasks"

task :test do
  require 'rake/testtask'
  Rake::TestTask.new do |task|
    task.libs << 'lib' << 'test'
    task.pattern = 'test/**/test_*.rb'
    task.verbose = true
  end
end

task :report do
  require 'simplecov'
  SimpleCov.start
end

task :default => [:test]
