require_relative 'lib/theusual/version'

Gem::Specification.new do |s|
  s.name        = 'theusual'
  s.version     = TheUsual::VERSION
  s.authors     = ['Daniel Pepper']
  s.summary     = 'TheUsual'
  s.description = 'A handful of useful hacks...good for any project'
  s.homepage    = 'https://github.com/dpep/rb_theusual'
  s.license     = 'MIT'

  s.files       = Dir.glob('lib/**/*')

  s.required_ruby_version = '>= 3.3'

  s.add_development_dependency 'debug'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
end
