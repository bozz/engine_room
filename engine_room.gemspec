# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "engine_room/version"

Gem::Specification.new do |s|
  s.name        = "engine_room"
  s.version     = EngineRoom::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Boris Searles"]
  s.email       = ["boris@lucidgardens.com"]
  s.homepage    = "http://github.com/bozz/engine_room"
  s.summary     = %q{Unobtrusive rails admin interface}
  s.description = %q{EngineRoom aims to be a simple to use, unobtrusive admin interface for rails applications. It is designed to be an add-on for existing web apps and not a full blown CMS. Just add EngineRoom to an app and it will create a customizable interface for editing the content data.}

  s.rubyforge_project = "engine_room"
  
  s.add_dependency 'devise', '~> 1.1.3'
  #s.add_dependency 'cancan', '~> 0.8.2'
  s.add_dependency 'rails', '~> 3.0.3'
  s.add_dependency 'crummy', '~> 1.0.1'
  s.add_dependency 'will_paginate', '3.0.pre2'
  s.add_dependency 'paperclip'
  s.add_development_dependency 'capybara', '>= 0.3.9'
  s.add_development_dependency 'webrat'  ## TODO: remove?
  s.add_development_dependency 'rspec-rails', '~> 2.3.0'
  s.add_development_dependency 'factory_girl_rails', '1.0'
  s.add_development_dependency 'spork'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'sqlite3-ruby'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
