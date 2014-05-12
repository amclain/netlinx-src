require 'netlinx/rake/src/pack'
require 'netlinx/rake/src/unpack'
require 'netlinx/rake/src/srcignore'
require 'netlinx/rake/src/mkzip'
require 'netlinx/rake/src/delzip'

NetLinx::Rake::Pack.new
NetLinx::Rake::Unpack.new
NetLinx::Rake::SrcIgnore.new
NetLinx::Rake::MkZip.new
NetLinx::Rake::DelZip.new
