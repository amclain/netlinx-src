version = File.read(File.expand_path('../version', __FILE__)).strip

Gem::Specification.new do |s|
  s.name      = 'netlinx-src'
  s.version   = version
  s.date      = Time.now.strftime '%Y-%m-%d'
  s.summary   = 'A utility for managing NetLinx Source (.src) files.'
  s.description = ""
  s.homepage  = 'https://sourceforge.net/projects/netlinx-src/'
  s.authors   = ['Alex McLain']
  s.email     = 'alex@alexmclain.com'
  s.license   = 'Apache 2.0'
  
  s.files     =
    ['license.txt', 'README.txt'] +
    Dir['bin/**/*'] +
    Dir['lib/**/*'] +
    Dir['doc/**/*']
  
  s.executables = [
  ]
  
  s.add_dependency('rubyzip', '=0.9.9')
  
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('pry')
end
