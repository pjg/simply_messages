# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "simply_messages/version"

Gem::Specification.new do |s|
  s.name = 'simply_messages'
  s.version = SimplyMessages::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Paweł Gościcki']
  s.email = ['pawel.goscicki@gmail.com']
  s.homepage = 'https://github.com/pjg/simply_messages'
  s.summary = 'Unified flash notices and model error messages display solution'
  s.description = 'simply_messages is a unified flash and error messages display solution'

  s.rubyforge_project = 'simply_messages'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = ['README.rdoc']
  s.require_paths = ['lib']

  s.licenses = ['MIT']

  s.add_dependency 'rails', ['>= 3.0.0']
  s.add_development_dependency 'bundler', ['>= 1.0.0']
  s.add_development_dependency 'sqlite3', ['>= 0']
end
