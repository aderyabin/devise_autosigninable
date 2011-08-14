# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "devise_autosigninable/version"

Gem::Specification.new do |s|
  s.name = %q{devise_autosigninable}
  s.version = DeviseAutosigninable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Andrey Deryabin"]
  s.date = Date.today
  s.description = %q{It adds support to be logged in by uniq link.}
  s.summary = %q{It adds support to be logged in by uniq link. It useful for mailing and access from admin panel.}
  s.email = %q{deriabin@gmail.com}
  s.homepage = %q{http://github.com/evilmartians/devise_autosigninable}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

