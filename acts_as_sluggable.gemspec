# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "acts_as_sluggable"
  s.version     = "1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Dunae", "Lance Ivy"]
  s.email       = ["?", "lance@kickstarter.com"]
  s.homepage    = "https://github.com/cainlevy/acts_as_sluggable"
  s.summary     = "acts_as_sluggable, modernized"
  s.description = "acts_as_sluggable, modernized"

  s.add_dependency "activerecord", ">= 3.0.0"

  s.add_development_dependency "rake"
  s.add_development_dependency "sqlite3"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
