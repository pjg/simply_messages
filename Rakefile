# encoding: utf-8

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  require 'simply_messages/version'

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "simply_messages #{SimplyMessages::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
