# -*- encoding: utf-8 -*-

require_relative 'lib/mass_invite'

Gem::Specification.new do |gem|
  gem.name          = 'mass_invite'
  gem.version       = MassInvite::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Hamed Ramezanian Nik']
  gem.email         = ['hamed.r.nik@gmail.com']
  gem.summary       = 'This library can be pluggled into a bigger application '\
    'and solve the problem with mass invitation for your users/customers.'
  gem.description   = 'This library can be pluggled into a bigger application '\
    'and solve the problem with mass invitation for your users/customers.'
  gem.homepage      = 'https://github.com/iCEAGE/mass_invite'
  gem.license       = 'LGPL-3.0'

  gem.files         = `git ls-files | grep -Ev '^(myapp|examples)'`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map do |f|
    File.basename(f)
  end
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.4'

  gem.add_development_dependency 'rake', '~> 12.0'
  gem.add_development_dependency 'minitest', '~> 5.10', '>= 5.10.1'
end
