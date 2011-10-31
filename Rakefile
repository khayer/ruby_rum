require "bundler/gem_tasks"

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  #t.test_files = FileList['test/test*.rb']
  t.test_files = FileList['test/test_blat_parser.rb']
  t.verbose = true
end