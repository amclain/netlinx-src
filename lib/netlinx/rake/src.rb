require 'netlinx/rake/src/pack'
require 'netlinx/rake/src/unpack'
require 'netlinx/rake/src/srcignore'
require 'netlinx/rake/src/to_zip'
require 'netlinx/rake/src/del_zip'

NetLinx::Rake::Pack.new
NetLinx::Rake::Unpack.new
NetLinx::Rake::SrcIgnore.new
NetLinx::Rake::ToZip.new
NetLinx::Rake::DelZip.new
