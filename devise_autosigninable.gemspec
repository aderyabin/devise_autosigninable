require "devise_autosigninable/version"

Gem::Specification.new do |s|
  s.name = %q{devise_autosigninable}
  s.version = DeviseAutosigninable::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Andrey Deryabin"]
  s.date = Date.today
  s.description = ["It adds support to be logged in by uniq link."]
  s.summary = ["It adds support to be logged in by uniq link. It useful for mailing and access from admin panel."]
  s.email = ["ad@evl.ms"]
  s.homepage =["http://github.com/evilmartians/devise_autosigninable"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.rdoc_options = ["--main", "README.rdoc", "--charset=UTF-8"]

  s.required_ruby_version     = '>= 1.8.6'
  s.required_rubygems_version = '>= 1.3.6'

  s.add_development_dependency('bundler', '~> 1.1.0')

  {
    'rails'  => '~> 3.0',
    'devise' => '~> 2.0.0'
  }.each do |lib, version|
    s.add_runtime_dependency(lib, *version)
  end
end

