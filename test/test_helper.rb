ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

require 'test/unit'
require 'rubygems'

# Optional gems
begin
  require 'redgreen'
rescue LoadError
end

# Load Rails
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))
