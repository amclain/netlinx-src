require 'rake'
require 'rake/tasklib'
require 'netlinx/src/package'

module NetLinx
  module Rake
    
    # Copy .src file and append .zip.
    class MkZip < ::Rake::TaskLib
      
      attr_accessor :name
      
      
      def initialize name = :mkzip
        @name = name
        
        yield self if block_given?
        
        define
      end
      
      
      protected
      
      def define
        desc "Copy .src file and append .zip."
        
        # TODO: Creates the project .src file if it doesn't exist.
        
        task(name) do
          Dir['*.src'].each { |file| NetLinx::SRC::Package.new(file: file).copy_to_zip }
        end
      end
      
    end
    
  end
end
