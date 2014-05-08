require 'rake'
require 'rake/tasklib'
require 'netlinx/project_package'

module NetLinx
  module Rake
    
    class Pack < ::Rake::TaskLib
      
      attr_accessor :name
      
      
      def initialize name = :pack
        @name = name
        
        yield self if block_given?
        
        define
      end
      
      
      protected
      
      def define
        desc "Generate a NetLinx .src source code package."
        
        task(name) do
          # TODO: Implement.
          puts "it works"
        end
      end
      
    end
    
  end
end
