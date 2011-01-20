# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "motp/version"

Gem::Specification.new do |s|
  s.name        = "motp"
  s.version     = Motp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Dan Q"]
  s.email       = ["dan@scatmania.org"]
  s.homepage    = "http://www.scatmania.org/projects/motp"
  s.summary     = %q{Methods for implementing a Mobile One-Time Pad client or server in Ruby.}
  s.description = %q{Methods for implementing a Mobile One-Time Pad client or server in Ruby.}

  s.rubyforge_project = "motp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
