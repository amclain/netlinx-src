require 'rake'
require 'rake/tasklib'
require 'netlinx/src/package'

module NetLinx
  module Rake
    
    class SrcIgnore < ::Rake::TaskLib
      
      attr_accessor :name
      
      
      def initialize name = :srcignore
        @name = name
        
        yield self if block_given?
        
        define
      end
      
      
      protected
      
      def define
        desc "Generate a default .srcignore file."
        
        task(name) do
          NetLinx::SRC::Package.new.make_srcignore
        end
      end
      
    end
    
  end
end
