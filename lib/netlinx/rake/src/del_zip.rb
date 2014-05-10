require 'rake'
require 'rake/tasklib'
require 'netlinx/src/package'

module NetLinx
  module Rake
    
    # Delete .src.zip files.
    class DelZip < ::Rake::TaskLib
      
      attr_accessor :name
      
      
      def initialize name = :delzip
        @name = name
        
        yield self if block_given?
        
        define
      end
      
      
      protected
      
      def define
        desc "Delete .src.zip files."
        
        task(name) do
          Dir['*.src.zip'].each { |file| File.delete file }
        end
      end
      
    end
    
  end
end
