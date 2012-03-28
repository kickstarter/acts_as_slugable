# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "acts_as_sluggable"
  s.version     = "1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["lance@kickstarter.com"]
  s.email       = ["lance@kickstarter.com"]
  s.homepage    = "https://github.com/kickstarter/acts_as_sluggable"
  s.summary     = "acts_as_sluggable, forked and updated"
  s.description = "acts_as_sluggable, forked and updated"

  s.add_dependency "activerecord", ">= 3.0.0"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rake", "0.8.7"
  
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
