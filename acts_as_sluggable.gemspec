# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "acts_as_slugable"
  s.version     = "1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Dunae", "Lance Ivy"]
  s.email       = ["lance@kickstarter.com"]
  s.homepage    = "https://github.com/kickstarter/acts_as_slugable"
  s.summary     = "acts_as_slugable, forked and updated"
  s.description = "acts_as_slugable, forked and updated"

  s.add_dependency "activerecord", ">= 3.0.0"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rake", "0.8.7"
  
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end


Gem::Specification.new do |s|
  s.name        = "paranoia"
  s.version     = Paranoia::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["radarlistener@gmail.com"]
  s.email       = []
  s.homepage    = "http://rubygems.org/gems/paranoia"
  s.summary     = "acts_as_paranoid, without the clusterfuck"
  s.description = "acts_as_paranoid, without the clusterfuck"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "paranoia"
  
  s.add_dependency "activerecord", ">= 3.0.0"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rake", "0.8.7"
  
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
