require 'rake'
require 'rake/tasklib'
require 'netlinx/src/package'

module NetLinx
  module Rake
    
    class ToZip < ::Rake::TaskLib
      
      attr_accessor :name
      
      
      def initialize name = :tozip
        @name = name
        
        yield self if block_given?
        
        define
      end
      
      
      protected
      
      def define
        desc "Copy .src file and append .zip."
        
        task(name) do
          Dir['*.src'].each { |file| NetLinx::SRC::Package.new(file: file).copy_to_zip }
        end
      end
      
    end
    
  end
end
