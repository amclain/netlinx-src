version = File.read(File.expand_path('../version', __FILE__)).strip

Gem::Specification.new do |s|
  s.name      = 'netlinx-src'
  s.version   = version
  s.date      = Time.now.strftime '%Y-%m-%d'
  s.summary   = 'A toolset for working with NetLinx source code packages (.src).'
  s.description = ""
  s.homepage  = 'https://sourceforge.net/projects/netlinx-src/'
  s.authors   = ['Alex McLain']
  s.email     = 'alex@alexmclain.com'
  s.license   = 'Apache 2.0'
  
  s.files     =
    ['license.txt', 'README.md'] +
    Dir['bin/**/*'] +
    Dir['lib/**/*'] +
    Dir['doc/**/*']
  
  s.executables = [
  ]
  
  s.add_dependency 'rubyzip', '~>1.1'
  s.add_dependency 'netlinx-workspace', '~>0.3.0'
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'fivemat'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rb-readline'
end
