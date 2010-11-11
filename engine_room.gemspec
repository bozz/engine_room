# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "engine_room/version"

Gem::Specification.new do |s|
  s.name        = "engine_room"
  s.version     = EngineRoom::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Boris Searles"]
  s.email       = ["boris@lucidgardens.com"]
  s.homepage    = "http://github.com/bozz/engineroom"
  s.summary     = %q{Unobtrusive rails admin interface}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "engine_room"
  
  s.add_dependency 'devise', '~> 1.1.3'
  #s.add_dependency 'cancan', '~> 0.8.2'
  s.add_dependency 'rails', '~> 3.0.1'
  s.add_development_dependency 'capybara', '>= 0.3.9'
  s.add_development_dependency 'webrat'
  s.add_development_dependency 'rspec-rails', '~> 2.1.0'
  s.add_development_dependency 'sqlite3-ruby'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
