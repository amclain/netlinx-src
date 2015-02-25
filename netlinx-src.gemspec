version = File.read(File.expand_path('../version', __FILE__)).strip

Gem::Specification.new do |s|
  s.name      = 'netlinx-src'
  s.version   = version
  s.date      = Time.now.strftime '%Y-%m-%d'
  s.summary   = 'A toolset for working with NetLinx source code packages (.src).'
  s.description = ""
  s.homepage  = 'https://github.com/amclain/netlinx-src'
  s.authors   = ['Alex McLain']
  s.email     = ['alex@alexmclain.com']
  s.license   = 'Apache 2.0'
  
  s.files     =
    [
      'license.txt',
      'README.md'
    ] +
    Dir[
      'bin/**/*',
      'lib/**/*',
      'doc/**/*'
    ]
  
  s.executables = []
  
  s.add_dependency 'rubyzip', '~> 1.1'
  s.add_dependency 'netlinx-workspace', '>= 0.3.0', '< 2.0.0'
  
  s.add_development_dependency 'rake',      '~> 10.4'
  s.add_development_dependency 'yard',      '~> 0.8.7'
  s.add_development_dependency 'rspec',     '~> 3.2'
  s.add_development_dependency 'rspec-its', '~> 1.2'
  s.add_development_dependency 'fivemat',   '~> 1.3'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rb-readline'
end
