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
  s.test_files  = Dir.glob('test/**/test_*')

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
end
