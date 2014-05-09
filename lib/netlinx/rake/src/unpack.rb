require 'rake'
require 'rake/tasklib'
require 'netlinx/src/package'
require 'netlinx/workspace'

module NetLinx
  module Rake
    
    class Unpack < ::Rake::TaskLib
      
      attr_accessor :name
      
      
      def initialize name = :unpack
        @name = name
        
        yield self if block_given?
        
        define
      end
      
      
      protected
      
      def define
        desc "Unpack a NetLinx .src source code package."
        
        task(name) do
          workspace = NetLinx::Workspace.search
          file_name = 'package.src'  # Default name if workspace not found.
          
          if workspace
            # Create package with workspace name.
            file_name = File.basename(workspace.file, '.apw') + '.src'
          end
          
          package = NetLinx::SRC::Package.new file: file_name
          package.unpack '_extracted'
        end
      end
      
    end
    
  end
end
