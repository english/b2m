require 'bundler'
require 'rake/clean'
require 'rake/testtask'

include Rake::DSL

Rake::TestTask.new(:spec) do |t|
  t.libs.push "lib"
  t.libs.push "spec"
  t.pattern = 'spec/**/*_spec.rb'
end

task :default => [:spec]
